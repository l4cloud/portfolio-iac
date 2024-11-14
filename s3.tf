resource "aws_s3_bucket" "portfolio" {
  bucket        = "l4-portfolio-bucket"
  force_destroy = true

  tags = {
    Name        = "Portfolio"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_website_configuration" "portfolio_website" {
  bucket = aws_s3_bucket.portfolio.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_account_public_access_block" "s3_access_block" {
  block_public_acls   = false
  block_public_policy = false
}
