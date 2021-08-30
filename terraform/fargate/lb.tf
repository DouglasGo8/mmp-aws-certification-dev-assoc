resource "aws_alb" "alb_main" {
  internal = "false"
  load_balancer_type = "application"
  enable_deletion_protection = false
  subnets = split(",", var.AWS_PUBLIC_SUBNETS)
  security_groups = [
    aws_security_group.lb-nsg.id]
  name = "${var.AWS_PROJECT_NAME}-alb-myapp-${var.AWS_ENVIRONMENT}"

  tags = {
    Name = "${var.AWS_PROJECT_NAME}-lb-${var.AWS_ENVIRONMENT}"
    Environment = var.AWS_ENVIRONMENT
  }
}

resource "aws_alb_target_group" "alb-tg-main" {

  port = var.AWS_LB_PORT
  vpc_id = var.AWS_VPC_ID
  target_type = "ip"
  protocol = var.AWS_LB_PROTOCOL
  deregistration_delay = 30

  health_check {
    path = var.AWS_LB_HEALTH_CHECK_PATH
    protocol = var.AWS_LB_PROTOCOL
    matcher = 200
    interval = 30
    timeout = 10
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
  tags = {
    Name = "${var.AWS_PROJECT_NAME}-alb-tg-${var.AWS_ENVIRONMENT}"
    Environment = var.AWS_ENVIRONMENT
  }

  name = "${var.AWS_PROJECT_NAME}-alb-tb-${var.AWS_ENVIRONMENT}"
}