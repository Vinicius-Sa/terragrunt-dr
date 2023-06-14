variable "public_subnets" {
  description = "A list of public subnets to deploy ec2 instances"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets availably to deploy ec2 instances"
  type        = list(string)
}

variable "azs" {
  description = "A list of azs for the VPC"
  type        = list(string)
}
