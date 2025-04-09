output "api_gateway_invoke_url" {
  value       = aws_apigatewayv2_api.api.api_endpoint
  description = "Public URL to invoke the API Gateway"
}