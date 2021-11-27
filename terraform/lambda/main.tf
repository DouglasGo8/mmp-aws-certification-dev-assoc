resource "aws_lambda_function" "hello_lambda" {
  function_name    = var.AWS_LAMBDA_FUNCTION_NAME
  filename         = "${path.module}/../../mp-lambda-quarkus/target/function.zip"
  role             = aws_iam_role.hello_lambda_role.arn
  depends_on       = [aws_cloudwatch_log_group.hello_lambda_logging]
  #runtime          = "java11" // Java 11 (Corretto) as Runtime
  runtime          = "provided" // Native execution using Java + GraalVM
  handler          = var.AWS_LAMBDA_HANDLER
  #timeout          = 10
  #memory_size      = 512 # Java Corretto 11
  memory_size      = 128 // Native execution using Java + GraalVM
  source_code_hash = base64sha256("${path.module}/../../mp-lambda-quarkus/target/function.zip")
}

