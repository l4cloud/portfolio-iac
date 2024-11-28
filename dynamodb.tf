resource "aws_dynamodb_table" "visitors" {
  name             = "visitors"
  hash_key         = "visitors_table_hash_key"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "visitors_table_hash_key"
    type = "S"
  }

  replica {
    region_name = "eu-west-2"
  }
}
