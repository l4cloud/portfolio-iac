resource "aws_s3_bucket" "test" {
  bucket = "l4-cloud-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
