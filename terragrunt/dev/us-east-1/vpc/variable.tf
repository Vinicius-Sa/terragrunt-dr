variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "cidr" {
  type = string
}

variable "azs" {
  description = "A list of azs for the VPC"
  type        = list(string)
  default     = []
}

variable "name" {
  type = string
}


