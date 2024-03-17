module "lb_security_group" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "5.1.2"
  description = "Load Balancer security group"

  name            = "loadbalancer-lab"
  use_name_prefix = true

  vpc_id = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = [
    "http-80-tcp",
    "https-443-tcp",
  ]

  egress_rules = ["all-all"]
}

module "instance_security_group" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "5.1.2"
  description = "Instances security group"

  name            = "instance-lb-lab"
  use_name_prefix = true

  vpc_id = data.aws_vpc.default.id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.lb_security_group.security_group_id
    }
  ]

  egress_rules = ["all-all"]
}
