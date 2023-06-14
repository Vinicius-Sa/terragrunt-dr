
locals {
  security_groups = {

    web_server_sg = {

      name        = var.sg_name_web
      description = "WEB server security group on default VPC"
      vpc_id      = var.vpc_id

      ingress = [
        {
          description = "Allowing tcp ingress traffic from subnets cidr_blocks at HTTPS default port"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = join(",", var.web_sg_cidr_blocks)
        }
      ]

      egress = [
        {
          description = "Allowing all egress traffic"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = "0.0.0.0/0"
        }
      ]
    },

    rds_server_sg = {

      name        = var.sg_name_rds
      description = "WEB server security group on default VPC"
      vpc_id      = var.vpc_id

      ingress = [
        /*{
          from_port        = 3306
          to_port          = 3306
          protocol         = "tcp"
          security_groups  = [module.security_groups.web_server_sg.id]
        },*/

        {
          description = "Allowing tcp ingress traffic from subnets cidr_blocks at AURORA default port"
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          cidr_blocks = join(",", var.rds_sg_cidr_blocks)
        }
      ]

      egress = [
        {
          description = "Allowing all egress traffic"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = "0.0.0.0/0"
        }
      ]
    }
  }
}

module "sg" {
  source  = "terraform-aws-modules/security-group/aws"

  for_each                    = local.security_groups

  name                        = each.value.name
  description                 = each.value.description
  vpc_id                      = each.value.vpc_id
  ingress_with_cidr_blocks    = each.value.ingress
  egress_with_cidr_blocks     = each.value.egress
}
