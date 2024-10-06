include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//rds-database"  # Path to the RDS module
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    required_var_files = ["${get_parent_terragrunt_dir()}/common.tfvars"]
  }
}

dependency "vpc" {
  config_path = "../vpc"  # Assuming RDS is deployed in the same VPC as EKS
}

inputs = {
  engine                  = "postgres"
  engine_version          = "13.3"
  instance_class          = "db.t3.medium"
  allocated_storage       = 20  # in GB
  max_allocated_storage   = 100 # Auto-scaling up to this storage
  username                = "db_admin"
  password                = data.aws_secretsmanager_secret_version.db_password.secret_string
  database_name           = "app_database"

  # Fetching the private subnets from VPC dependency for better security
  subnet_ids              = dependency.vpc.outputs.vpc.private_subnets

  # Additional RDS configurations (modify as per requirements)
  multi_az                = true
  publicly_accessible      = false
  backup_retention_period = 7   # Keep backups for 7 days
  storage_type            = "gp2"
  vpc_security_group_ids  = []  # Add the security groups if any
}
