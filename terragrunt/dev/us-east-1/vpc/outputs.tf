output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "default_security_group_id" {
  value = module.vpc.default_vpc_default_security_group_id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "default_vpc_id" {
  value = module.vpc.default_vpc_id
}

output "azs" {
  value = module.vpc.azs
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

