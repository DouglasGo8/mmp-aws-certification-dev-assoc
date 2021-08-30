
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.AWS_PROJECT_NAME}-${var.AWS_ENVIRONMENT}"
  assume_role_policy = file("${path.module}/policies/ecs-task-execution-role.json")
}