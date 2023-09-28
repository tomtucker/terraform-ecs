locals {
  region       = var.region
  project_name = var.project_name
  environment  = var.environment
}

# Create VPC module with 2 public and 2 private subnets
module "vpc" {
  source                       = "git@github.com:tomtucker/terraform-modules.git//vpc"
  region                       = local.region
  project_name                 = local.project_name
  environment                  = local.environment
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}

# Create NAT Gateways
module "nat_gateway" {
  source                     = "git@github.com:tomtucker/terraform-modules.git//nat-gw"
  project_name               = local.project_name
  environment                = local.environment
  vpc_id                     = module.vpc.vpc_id
  internet_gateway           = module.vpc.internet_gateway
  public_subnet_az1_id       = module.vpc.public_subnet_az1_id
  public_subnet_az2_id       = module.vpc.public_subnet_az2_id
  private_app_subnet_az1_id  = module.vpc.private_app_subnet_az1_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
}

# Create Security Groups
module "security_groups" {
  # source       = "../terraform-modules/security-groups"
  source       = "git@github.com:tomtucker/terraform-modules.git//security-groups"
  project_name = local.project_name
  environment  = local.environment
  vpc_id       = module.vpc.vpc_id
  ssh_ip       = var.ssh_ip
}

# Create RDS
module "rds" {
  # source                     = "../terraform-modules/rds"
  source                     = "git@github.com:tomtucker/terraform-modules.git//rds"
  project_name               = local.project_name
  environment                = local.environment
  db_engine                  = var.db_engine
  db_engine_version          = var.db_engine_version
  db_instance_class          = var.db_instance_class
  db_name                    = var.db_name
  db_username                = var.db_username
  db_password                = var.db_password
  db_allocated_storage       = var.db_allocated_storage
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
  availability_zone_1        = module.vpc.availability_zone_1
  multi_az_deployment        = var.multi_az_deployment
  database_security_group_id = module.security_groups.database_security_group_id
  skip_final_snapshot        = var.skip_final_snapshot
}

# Rquest SSL Certificate
module "ssl_certificate" {
  #source             = "../terraform-modules/acm"
  source            = "git@github.com:tomtucker/terraform-modules.git//acm"
  project_name      = local.project_name
  environment       = local.environment
  domain_name       = var.domain_name
  alternative_names = [var.alternative_names]
}

# Create Application Load Balancer
module "application_load_balancer" {
  # source             = "../terraform-modules/alb"
  source                = "git@github.com:tomtucker/terraform-modules.git//alb"
  project_name          = local.project_name
  environment           = local.environment
  alb_security_group_id = module.security_groups.alb_security_group_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  target_type           = var.target_type
  vpc_id                = module.vpc.vpc_id
  certificate_arn       = module.ssl_certificate.certificate_arn
}

# Create S3 Bucket and copy application environment file
module "s3_bucket" {
  # source            = "../terraform-modules/s3"
  source               = "git@github.com:tomtucker/terraform-modules.git//s3"
  project_name         = local.project_name
  env_file_bucket_name = var.env_file_bucket_name
  env_file_name        = var.env_file_name
}

# Create ECS Task Execution Role
module "ecs_task_execution_role" {
  # source               = "../terraform-modules/iam-role"
  source               = "git@github.com:tomtucker/terraform-modules.git//iam-role"
  project_name         = local.project_name
  env_file_bucket_name = module.s3_bucket.env_file_bucket_name
  environment          = local.environment
}

# Create ECS Cluster, Task Definition, and Service
module "ecs" {
  # source                       = "../terraform-modules/ecs"
  source                       = "git@github.com:tomtucker/terraform-modules.git//ecs"
  project_name                 = local.project_name
  environment                  = local.environment
  ecs_task_execution_role_arn  = module.ecs_task_execution_role.ecs_task_execution_role_arn
  architecture                 = var.architecture
  container_image              = var.container_image
  env_file_bucket_name         = module.s3_bucket.env_file_bucket_name
  env_file_name                = module.s3_bucket.env_file_name
  region                       = local.region
  private_app_subnet_az1_id    = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id    = module.vpc.private_app_subnet_az2_id
  app_server_security_group_id = module.security_groups.app_server_security_group_id
  alb_target_group_arn         = module.application_load_balancer.alb_target_group_arn
}

# Create Auto Scaling Group (ASG) for ECS Service
module "ecs-asg" {
  # source       = "../terraform-modules/asg-ecs"
  source       = "git@github.com:tomtucker/terraform-modules.git//asg-ecs"
  project_name = local.project_name
  environment  = local.environment
  ecs_service  = module.ecs.ecs_service
}

# Create Route 53 DNS record for application
module "route_53" {
  # source                             = "../terraform-modules/route-53"
  source                             = "git@github.com:tomtucker/terraform-modules.git//route-53"
  domain_name                        = module.ssl_certificate.domain_name
  record_name                        = var.record_name
  application_load_balancer_dns_name = module.application_load_balancer.application_load_balancer_dns_name
  application_load_balancer_zone_id  = module.application_load_balancer.application_load_balancer_zone_id
}

# Print the application URL
output "website_url" {
  value = join("", ["https://", var.record_name, ".", var.domain_name])
}
