module "lb_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.1"

  bucket_prefix = "lb-lab-logs"
  acl           = "private"

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = "aws:kms"
      }
    }
  }

  control_object_ownership = true
  object_ownership         = "ObjectWriter"
}

resource "aws_s3_bucket_policy" "allow_access_logs_loadbalancer" {
  bucket = module.lb_logs.s3_bucket_id
  policy = data.aws_iam_policy_document.loadbalancer_bucket_policy_document.json

  depends_on = [
    module.lb_logs,
    data.aws_iam_policy_document.loadbalancer_bucket_policy_document
  ]
}
