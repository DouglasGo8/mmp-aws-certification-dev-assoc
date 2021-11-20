data "aws_iam_policy_document" "hello_lambda_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cloudwatch_role_policy_document" {
  statement {
    effect    = "Allow"
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [aws_cloudwatch_log_group.hello_lambda_logging.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.hello_lambda_logging.arn}:*"]
  }

}


data "aws_iam_policy_document" "dynamodb_LanguageScore-table_policy" {

  statement {
    effect    = "Allow"
    actions   = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:DescribeTable"
    ]
    resources = ["arn:aws:dynamodb:sa-east-1:501317491826:table/LanguageScore-table"]
  }

}