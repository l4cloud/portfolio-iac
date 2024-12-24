resource "aws_api_gateway_rest_api" "viewer_api" {
  name        = "viewer_api"
  description = "My Api Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
    aws_api_gateway_integration.options_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.viewer_api.id
  stage_name  = "dev"
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.viewer_api.id
  parent_id   = aws_api_gateway_rest_api.viewer_api.root_resource_id
  path_part   = "view"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.increment_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.viewer_api.execution_arn}/*/*/*"
}

