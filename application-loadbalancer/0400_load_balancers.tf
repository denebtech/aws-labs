module "lb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.8.0"

  name    = "loadbalancer-lab"
  vpc_id  = data.aws_vpc.default.id
  subnets = data.aws_subnets.default.ids

  security_groups       = [module.lb_security_group.security_group_id]
  create_security_group = false

  listeners = {
    ex-http = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    ex-https = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn = module.acm.acm_certificate_arn

      fixed_response = {
        content_type = "text/plain"
        message_body = "OK"
        status_code  = "200"
      }
    }
  }

  access_logs = {
    bucket = module.lb_logs.s3_bucket_id
    prefix = "access-logs"
  }

  connection_logs = {
    bucket = module.lb_logs.s3_bucket_id
    prefix = "connection-logs"
  }

  depends_on = [aws_s3_bucket_policy.allow_access_logs_loadbalancer]
}
