resource "aws_route53_zone" "primary" {
  name = var.hostname 
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.hostname 
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_disribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_disribution.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "cert" {
  provider = aws.ue1
  domain_name = var.hostname 
  validation_method = "DNS"
}

resource "aws_route53_record" "l4_cert_dns" {
  provider = aws.ue1
  allow_overwrite = true
  name =  tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  records = [tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value]
  type = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  zone_id = aws_route53_zone.primary.zone_id
  ttl = 60
}

resource "aws_acm_certificate_validation" "l4_cert_validate" {
  provider = aws.ue1
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.l4_cert_dns.fqdn]
}
