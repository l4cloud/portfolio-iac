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
