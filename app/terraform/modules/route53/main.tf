data "aws_route53_zone" "mlops_zone" {
  name = var.zone_name
}

resource "aws_route53_record" "mlops_cname_record" {
  zone_id = data.aws_route53_zone.mlops_zone.id
  name    = var.record_name
  type    = "CNAME"
  ttl     = var.ttl
  records = [var.alb_dns_name]
}