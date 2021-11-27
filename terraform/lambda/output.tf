output "deployment_invoke_url" {
  description = "Deployment invoke url"
  value       = aws_api_gateway_deployment.hello_lambda_api_gwt_deploy.invoke_url
}
