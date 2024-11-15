resource "aws_route53_zone" "primary" {
  name = "l4-dev.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "l4-dev.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_disribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_disribution.hosted_zone_id
    evaluate_target_health = true
  }
}
