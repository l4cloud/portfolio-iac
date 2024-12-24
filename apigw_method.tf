resource "aws_api_gateway_method" "options_method" {
  rest_api_id   = aws_api_gateway_rest_api.viewer_api.id
  resource_id   = aws_api_gateway_resource.root.id
  http_method   = "OPTIONS"
  authorization = "NONE"


}

resource "aws_api_gateway_method_response" "options_resposne" {
  rest_api_id = aws_api_gateway_rest_api.viewer_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true,
  }
}

resource "aws_api_gateway_method" "lambda_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.viewer_api.id
  resource_id   = aws_api_gateway_resource.root.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "lambda_get_response" {
  rest_api_id = aws_api_gateway_rest_api.viewer_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.lambda_get_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true,
  }
}
