output "security_group_ids" {
  value = module.sg[*]
}

output "rds_security_group_id" {
  value = module.sg[*].rds_server_sg.security_group_id
}

output "web_security_group_id" {
  value = module.sg[*].web_server_sg.security_group_id
}