terraform {
  source = "../rds-aurora"
}

include {
  path = find_in_parent_folders()
}

locals {
  env_vars = yamldecode(file(find_in_parent_folders("env.yaml")))
}

dependency "sg" {
  config_path = find_in_parent_folders("sg")

  mock_outputs = {
    security_group_ids =[
      "security_group_id0",
      "security_group_id1"
    ]
  }
}

inputs = {
  cluster_name                 = "dr-cluster"
  instance_class               = "db.t3.medium"
  instance_count               = 1
  password                     = "admin123"
  preferred_maintenance_window = ""
  rds_db_parameter_group_name  = "aurora-cluster-pg-${local.env_vars.env}"
  skip_final_snapshot          = 1
  vpc_security_group_ids       = dependency.sg.outputs.security_group_ids
}