data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_route53_zone" "denebtech_com_ar" {
  name = local.domain
}

data "aws_iam_policy_document" "loadbalancer_bucket_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::027434742980:root"]
    }
    resources = [
      "arn:aws:s3:::${module.lb_logs.s3_bucket_id}/access-logs/AWSLogs/378473339388/*",
      "arn:aws:s3:::${module.lb_logs.s3_bucket_id}/connection-logs/AWSLogs/378473339388/*",
    ]
  }

  depends_on = [module.lb_logs]
}
