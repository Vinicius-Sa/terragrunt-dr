##################################             ###############################
#                                     EC2                                    #
##################################             ###############################
variable "associate_public_ip_address" {
  type        = string
  description = " Associate an public ipv4 ip to instance"
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "throughput" {
  type         = string
  description  = "Instance volume throughput"
  default      = null
}

variable "volume_size" {
  type         = string
  description  = " Instance volume size"
  default      = "gp3"
}

##################################                            ###############################
#                                     WEB INSTANCE CONFIGS                                  #
##################################                            ###############################


variable "server_name_web" {
  type        = string
  description = "Server name of WEB server instance"
}


variable "instance_type_web" {
  type         = string
  description  = "Instance type of BASTION server"
}

variable "volume_type_web" {
  type         = string
  description  = "Volume type for WEB instance"
  default      = "t2.micro"
}

variable "user_data_web" {
  type        = string
  description = "user_data script that will be executed on WEB instance launch"
}

##################################                              ###############################
#                                    BASTION INSTANCE CONFIGS                                 #
##################################                              ###############################

variable "server_name_bastion" {
  type        = string
  description = "Server name of BASTION server instance"
}

variable "instance_type_bastion" {
  type        = string
  description = "Instance type of BASTION server"
}

variable "volume_type_bastion" {
  type        = string
  description = "Volume type for WEB instance"
  default     = "t2.micro"
}

variable "user_data_bastion" {
  type        = string
  description = "user_data script that will be executed on BASTION instance launch"
}





