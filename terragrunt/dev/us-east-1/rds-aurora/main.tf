resource "aws_rds_cluster_parameter_group" "drpgroup" {
  name        = var.rds_db_parameter_group_name
  family      = "aurora5.7"
  description = "Aurora Symplicity Parameter Group"

  parameter {
    name  = "log_filename"
    value = "postgresql.log.%Y-%m-%d-%H"
  }

  parameter {
    name  = "binlog_format"
    value = "MIXED"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8"
  }

  parameter {
    name  = "time_zone"
    value = "US/Eastern"
  }
}

resource "aws_db_parameter_group" "drpg" {
  name   = "dr-sympparametergroup-barracuda"
  family = "aurora5.7"

  parameter {
    name  = "innodb_file_format"
    value = "Barracuda"
  }

  parameter {
    name  = "innodb_lock_wait_timeout"
    value = "120"
  }

  parameter {
    name  = "innodb_open_files"
    value = "60000"
  }

  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
  }

  parameter {
    name  = "max_allowed_packet"
    value = "1073741824"
  }
  parameter {
    name  = "slow_query_log"
    value = "0"
  }
  parameter {
    name  = "slow_buffer_size"
    value = "8388608"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_rds_cluster" "default" {
  db_cluster_parameter_group_name = "aws_rds_cluster_parameter_group.drpgroup"
  db_instance_parameter_group_name= "aws_db_parameter_group.drpg"
  allow_major_version_upgrade     = true
  cluster_identifier              = "aurora-${var.cluster_name}"
  master_username                 = "root"
  master_password                 = var.password
  engine                          = "aurora-mysql"
  engine_version                  = "5.7.mysql_aurora.2.10.2"
  backup_retention_period         = 35
  deletion_protection             = true
  final_snapshot_identifier       = var.cluster_name
  preferred_backup_window         = "21:00-22:00"
  preferred_maintenance_window    = var.preferred_maintenance_window
  vpc_security_group_ids          = var.vpc_security_group_ids

  tags = var.tags
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                                 = var.instance_count
  identifier                            = "${var.cluster_name}-${count.index}"
  cluster_identifier                    = aws_rds_cluster.default.id
  instance_class                        = var.instance_class
  engine                                = aws_rds_cluster.default.engine
  engine_version                        = aws_rds_cluster.default.engine_version
  publicly_accessible                   = true
  tags                                  = var.tags
  db_parameter_group_name               = aws_db_parameter_group.drpg.name
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  preferred_maintenance_window          = var.preferred_maintenance_window
  apply_immediately                     = true
  auto_minor_version_upgrade            = false
}
