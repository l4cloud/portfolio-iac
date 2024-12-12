resource "aws_dynamodb_table" "visitors" {
  name             = "visitors"
  hash_key         = "exampleHashKey"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "exampleHashKey"
    type = "S"
  }

  replica {
    region_name = "eu-west-2"
  }
}



resource "aws_dynamodb_table" "example" {
  name           = "example-name"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "exampleHashKey"

  attribute {
    name = "exampleHashKey"
    type = "S"
  }
}
