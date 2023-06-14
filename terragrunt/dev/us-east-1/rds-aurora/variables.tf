variable "tags" {
  type        = map(any)
  default     = {}
  description = "Tags definition."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = " List of VPC security groups to associate with the Cluster"
}

variable "instance_class" {
  type        = string
  description = "Instance class for database" #https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.DBInstanceClass.html
}

variable "password" {
  type        = string
  description = "Password for rds database root user."
}

variable "skip_final_snapshot" {
  type        = string
  description = "Allow auto destuction of database"
}

variable "instance_count" {
  type        = string
  description = "Instance count for rds cluster"
}

variable "cluster_name" {
  type        = string
  description = "Instance count for rds cluster"
}

variable "preferred_maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: \"ddd:hh24:mi-ddd:hh24:mi\". Eg: \"Mon:00:00-Mon:03:00\". UTC"
}

variable "rds_db_parameter_group_name" {
  type        = string
  description = "The name of the CLUSTER parameter group "
}
