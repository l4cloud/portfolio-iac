resource "aws_s3_bucket" "test" {
  bucket = "l4-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
