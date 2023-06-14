variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type = string
}

variable "web_sg_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type = list(string)
}

variable "rds_sg_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type = list(string)
}