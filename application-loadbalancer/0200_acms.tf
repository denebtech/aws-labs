module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.0.1"

  domain_name = local.domain
  zone_id     = data.aws_route53_zone.denebtech_com_ar.id

  validation_method = "DNS"

  subject_alternative_names = [
    "web1.lblab.${local.domain}",
  ]

  wait_for_validation = false
}
