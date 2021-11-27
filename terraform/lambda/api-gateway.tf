resource "aws_api_gateway_rest_api" "hello_lambda_rest_api_gwt" {
  name = "hello_lambda_rest_api"
}

resource "aws_api_gateway_resource" "hello_lambda_api_gwt_resource" {
  rest_api_id = aws_api_gateway_rest_api.hello_lambda_rest_api_gwt.id
  parent_id   = aws_api_gateway_rest_api.hello_lambda_rest_api_gwt.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "hello_lambda_api_gwt_method" {
  rest_api_id   = aws_api_gateway_rest_api.hello_lambda_rest_api_gwt.id
  resource_id   = aws_api_gateway_resource.hello_lambda_api_gwt_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "hello_lambda_api_gwt_integration" {
  http_method             = aws_api_gateway_method.hello_lambda_api_gwt_method.http_method
  resource_id             = aws_api_gateway_resource.hello_lambda_api_gwt_resource.id
  rest_api_id             = aws_api_gateway_rest_api.hello_lambda_rest_api_gwt.id
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.hello_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "hello_lambda_api_gwt_deploy" {
  depends_on  = [aws_api_gateway_integration.hello_lambda_api_gwt_integration]
  rest_api_id = aws_api_gateway_rest_api.hello_lambda_rest_api_gwt.id
  stage_name  = "dev"
}

resource "aws_lambda_permission" "test_lambda_api_gateway_permission" {
  function_name = var.AWS_LAMBDA_FUNCTION_NAME
  principal     = "apigateway.amazonaws.com"
  action        = "lambda:InvokeFunction"
  source_arn    = "${aws_api_gateway_rest_api.hello_lambda_rest_api_gwt.execution_arn}/*/*"

  depends_on = [aws_lambda_function.hello_lambda]
}
