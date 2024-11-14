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

resource "aws_s3_bucket_ownership_controls" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.portfolio]

  bucket = aws_s3_bucket.portfolio.id
  acl    = "public-read"
}

resource "aws_s3_account_public_access_block" "s3_access_block" {
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "portfolio_policy" {
  bucket = aws_s3_bucket.portfolio.id
  policy = data.aws_iam_policy_document.allow_get_object.json

  depends_on = [
    aws_s3_account_public_access_block.s3_access_block,
  ]
}

data "aws_iam_policy_document" "allow_get_object" {
  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.portfolio.arn}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
