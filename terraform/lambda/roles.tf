resource "aws_iam_role" "hello_lambda_role" {
  name               = "${var.AWS_LAMBDA_FUNCTION_NAME}-role"
  assume_role_policy = data.aws_iam_policy_document.hello_lambda_assume_role_policy.json
  tags               = {
    STAGE = "hello-lambda-dev"
  }

}

resource "aws_cloudwatch_log_group" "hello_lambda_logging" {
  name = "/aws/lambda/${var.AWS_LAMBDA_FUNCTION_NAME}"
}

resource "aws_iam_role_policy" "hello_lambda_cloudwatch_policy" {
  name   = "hello-lambda-dev-cloudwatch-policy"
  policy = data.aws_iam_policy_document.cloudwatch_role_policy_document.json
  role   = aws_iam_role.hello_lambda_role.id
}
