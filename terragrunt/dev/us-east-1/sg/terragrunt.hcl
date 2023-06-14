terraform {
  source = "../sg"
}

include {
  path = find_in_parent_folders()
}

locals {
  env_vars = yamldecode(file(find_in_parent_folders("env.yaml")))
}


dependency "vpc" {
  config_path = find_in_parent_folders("vpc")

  mock_outputs = {
    vpc_id          = "vpc-00000000"
    private_subnets = ["10.250.100.0/24", "10.250.101.0/24"]
    public_subnets  = ["10.250.200.0/24", "10.250.201.0/24"]
  }
}


inputs = {

  vpc_id      = dependency.vpc.outputs.vpc_id

  web_sg_cidr_blocks = dependency.vpc.outputs.public_subnets
  sg_name_web = "web-sg-${local.env_vars.env}"

  rds_sg_cidr_blocks = dependency.vpc.outputs.private_subnets
  sg_name_rds = "rds-sg-${local.env_vars.env}"



  #ingress_cidr_blocks = ["10.250.0.0/16"]
}
