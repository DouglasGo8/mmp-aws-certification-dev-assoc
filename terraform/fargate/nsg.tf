# SECURITY GROUPS

resource "aws_security_group" "service-nsg-task" {
  name        = "${var.AWS_PROJECT_NAME}-task-sg-${var.AWS_ENVIRONMENT}"
  description = "Limit connections from internal resources, but let ${var.AWS_PROJECT_NAME}-${var.AWS_ENVIRONMENT}-task to connect to all external resources"
  vpc_id      = var.AWS_VPC_ID

  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-task-sg-${var.AWS_ENVIRONMENT}"
    Environment = var.AWS_ENVIRONMENT
  }
}

resource "aws_security_group" "lb-nsg" {
  name        = "${var.AWS_PROJECT_NAME}-lb-sg-${var.AWS_ENVIRONMENT}"
  description = "Allow/Limiting connections from external/internal resources ${var.AWS_PROJECT_NAME}-${var.AWS_ENVIRONMENT}-lb resources"
  vpc_id      = var.AWS_VPC_ID
  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-lb-sg-${var.AWS_ENVIRONMENT}"
    Environment = var.AWS_ENVIRONMENT
  }
}

# RULES

resource "aws_security_group_rule" "sg_task_ingress_rule" {
  description = "Only allow connections from SG ${var.AWS_PROJECT_NAME}-${var.AWS_ENVIRONMENT}-lb on port ${var.AWS_CONTAINER_PORT_NUMBER}"
  type        = "ingress"
  from_port   = "0"
  to_port     = "0"
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  source_security_group_id = aws_security_group.lb-nsg.id
}

resource "aws_security_group_rule" "service-nsg-task-egress-rule" {
  description       = "Allows task to establish connections to all resources"
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.service-nsg-task.id
}

# Rules for the TASK (Targets the LB SG)
resource "aws_security_group_rule" "lb-sg-egress-rule" {
  description              = "Only allow SG ${var.AWS_PROJECT_NAME}-${var.AWS_ENVIRONMENT}-lb to connect to ${var.AWS_PROJECT_NAME}-${var.AWS_ENVIRONMENT}-task on port ${var.AWS_CONTAINER_PORT_NUMBER}"
  type                     = "egress"
  from_port                = var.AWS_CONTAINER_PORT_NUMBER
  to_port                  = var.AWS_CONTAINER_PORT_NUMBER
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.service-nsg-task.id

  security_group_id = aws_security_group.lb-nsg.id
}

# Rules for the TASK Health check endpoint
/*resource "aws_security_group_rule" "nsg_task_ingress_health_rule" {
  description              = "Only allow connections from SG ${var.AWS_PROJECT_NAME}-${var.AWS_ENVIRONMENT}-lb on port ${var.AWS_CONTAINER_PORT_HEALTH_NUMBER} to health check"
  type                     = "ingress"
  from_port                = var.AWS_CONTAINER_PORT_HEALTH_NUMBER
  to_port                  = var.AWS_CONTAINER_PORT_HEALTH_NUMBER
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb-nsg.id

  security_group_id = aws_security_group.service-nsg-task.id
}*/

resource "aws_security_group_rule" "nsg_task_ingress_rule" {
  description              = "Only allow connections from SG ${var.AWS_PROJECT_NAME}-${var.AWS_ENVIRONMENT}-lb on port ${var.AWS_CONTAINER_PORT_NUMBER}"
  type                     = "ingress"
  from_port                = var.AWS_CONTAINER_PORT_NUMBER
  to_port                  = var.AWS_CONTAINER_PORT_NUMBER
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb-nsg.id

  security_group_id = aws_security_group.service-nsg-task.id
}



