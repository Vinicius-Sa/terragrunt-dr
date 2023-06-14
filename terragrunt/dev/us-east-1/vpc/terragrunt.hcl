terraform {
  source = "../vpc"
}

include {
  path = find_in_parent_folders()
}

locals {
  env_vars = yamldecode(file(find_in_parent_folders("env.yaml")))
}

inputs = {
  name = "vpc-${local.env_vars.env}"
  cidr = "10.250.0.0/16"

  azs                         = ["us-east-1a", "us-east-1b"]
  private_subnets             = ["10.250.100.0/24", "10.250.101.0/24"]
  public_subnets              = ["10.250.200.0/24", "10.250.201.0/24"]

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false
}


