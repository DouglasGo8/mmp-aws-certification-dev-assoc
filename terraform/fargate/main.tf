# ECS cluster creation
resource "aws_ecs_cluster" "main-cluster" {
  name = "${var.AWS_PROJECT_NAME}-cluster-${var.AWS_ENVIRONMENT}"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-cluster-${var.AWS_ENVIRONMENT}"
    Environment = var.AWS_ENVIRONMENT
  }
}

# Task Definition
resource "aws_ecs_task_definition" "main-task" {
  cpu                      = var.AWS_CPU_MiB_SIZE
  memory                   = var.AWS_MEMORY_MiB_SIZE
  network_mode             = var.AWS_NETWORK_MODE
  requires_compatibilities = ["FARGATE"]
  family                   = "${var.AWS_PROJECT_NAME}-task-${var.AWS_ENVIRONMENT}"
  container_definitions    = data.template_file.app_task.rendered
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
}

# Service Definition
resource "aws_ecs_service" "main-service" {
  launch_type             = "FARGATE"
  scheduling_strategy     = "REPLICA"
  propagate_tags          = "SERVICE"
  enable_ecs_managed_tags = true
  cluster                 = aws_ecs_cluster.main-cluster.id
  desired_count           = var.AWS_CONTAINERS_MIN_REPLICAS
  task_definition         = aws_ecs_task_definition.main-task.arn
  name                    = "${var.AWS_PROJECT_NAME}-service-${var.AWS_ENVIRONMENT}"

  network_configuration {
    security_groups  = [aws_security_group.service-nsg-task.id]
    subnets          = [data.aws_subnet.main-private-1.id, data.aws_subnet.main-private-2.id, data.aws_subnet.main-private-3.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.alb-tg-main.id
    container_name   = var.AWS_CONTAINER_NAME
    container_port   = var.AWS_CONTAINER_PORT_NUMBER
  }
  # [after initial apply] don't override changes made to task_definition
  # from outside of terraform (i.e.; fargate cli)
  lifecycle {
    ignore_changes = [task_definition]
  }

  depends_on = [aws_alb_listener.alb-listener-http]

  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-service-${var.AWS_ENVIRONMENT}"
    Environment = var.AWS_ENVIRONMENT
  }
}

resource "aws_appautoscaling_target" "app_scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main-cluster.name}/${aws_ecs_service.main-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.AWS_CONTAINERS_MIN_REPLICAS
  max_capacity       = var.AWS_CONTAINERS_MAX_REPLICAS
}

resource "aws_cloudwatch_log_group" "quarkus_camel_app_logs" {
  name              = "quarkus_camel_app_logs"
  retention_in_days = var.logs_retention_in_days
  tags = {
    Environment = var.AWS_ENVIRONMENT
    Application = "QuarkusCamelApp"
  }
}
