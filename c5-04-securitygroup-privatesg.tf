# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances

module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"
  name =  "private-sg"
    description = "security group HTTP & ssh port open for entire VPC Block(ipv4 cidr)"
    vpc_id = module.vpc.vpc_id
#ingress rules & CIDR blocks
ingress_rules = ["ssh-tcp", "http-80-tcp"]
ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
ingress_with_source_security_group_id = [
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      source_security_group_id = module.public_bastion_sg.security_group_id
      description              = "SSH permitido solo desde el Bastion Host"
    }
  ]
#Egress rules
egress_rules = ["all-all"]
tags = local.common_tags
}









