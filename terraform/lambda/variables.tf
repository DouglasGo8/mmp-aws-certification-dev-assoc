variable "AWS_REGION" {
  default = "sa-east-1"
}

variable "AWS_PROFILE" {
  default = "default"
}

variable "AWS_LAMBDA_FUNCTION_NAME" {
  default = "hello_lambda"
}

variable "AWS_LAMBDA_HANDLER" {
  default = "io.quarkus.amazon.lambda.runtime.QuarkusStreamHandler::handleRequest"
}