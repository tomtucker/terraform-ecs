# Environment variables
variable "region" {}
variable "project_name" {}
variable "environment" {}

# VPC variables
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}

# Secuyrity Groups variable
variable "ssh_ip" {}

# RDS variables
variable "db_instance_class" {}
variable "multi_az_deployment" {}
variable "skip_final_snapshot" {}
variable "db_name" {}
variable "db_engine" {}
variable "db_engine_version" {}
variable "db_username" {}
variable "db_password" {}
variable "db_allocated_storage" {}

# ACM variables
variable "domain_name" {}
variable "alternative_names" {}

# Application Load Balancer variables
variable "target_type" {}

# S3 environment file variables
variable "env_file_bucket_name" {}
variable "env_file_name" {}

# ECS variables
variable "architecture" {}
variable "container_image" {}

# Route 53 variables
variable "record_name" {}
