
data "template_file" "app_task" {
  template = file("${path.module}/tasks/app_task_definition.json")
  vars = {
    aws_region = var.AWS_REGION
    #aws_db_host         = var.AWS_DB_HOST
    container_name      = var.AWS_CONTAINER_NAME
    container_image     = var.AWS_ECR_IMAGE_URI
    container_port      = var.AWS_CONTAINER_PORT_NUMBER
    container_memory    = var.AWS_MEMORY_MiB_SIZE
    project_name        = var.AWS_PROJECT_NAME
    project_environment = var.AWS_ENVIRONMENT
    log_group           = aws_cloudwatch_log_group.quarkus_camel_app_logs.name
  }
}

data "aws_iam_policy_document" "ecs_service_policy" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "ec2:Describe*",
      "ec2:AuthorizeSecurityGroupIngress"
    ]
  }
}

data "aws_iam_policy_document" "ecs_service_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

data "aws_subnet" "main-public-1" {
  id = "subnet-0b515fe2574cc7d0e"
}

data "aws_subnet" "main-public-2" {
  id = "subnet-0c8b5622705f9cb7a"
}

data "aws_subnet" "main-public-3" {
  id = "subnet-0ffa64e7393f36572"
}


data "aws_subnet" "main-private-1" {
  id = "subnet-06554b0e4909bc0eb"
}

data "aws_subnet" "main-private-2" {
  id = "subnet-079c26d389ff01ddb"
}

data "aws_subnet" "main-private-3" {
  id = "subnet-003bc1af63921c569"
}
