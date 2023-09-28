# terraform-ecs

This project demonstrates the use of Terraform to deploy a 3 tier dynamic web application in AWS Elastic Container Service (ECS) with an RDS backend.

It showcases the use of Terraform modules and variables to provide reusable, data driven components for the Infrastructure as Code (IaC) deployment. The specifics of the deployment care configurable through an (unpublished) `terraforms.tfvars` file which sets values passed to the Terraform modules through the main code file.

The modules are sourced from a separate, private, GitHub repository or can be sourced from local storage allowing separate maintenance and versioning from individual projects.

## Pre-requisites

* AWS Account
* AWS CLI installed & configured locally
* GitHub account
* GitHub repo with Terraform modules (Optionally modules can sourced locally)
* Git installed & configured locally
* Terraform installed locally
* ECR Repo
* SSH client installed locally
* EC2 Key Pair
* dBeaver or MySQL Workbench installed locally

## Steps

1. Create VPC with 2 public and 2 private subnets
2. Create NAT Gateway
3. Create Security Groups
4. Create RDS instance and empty database and users
    1. Manually create Bastion host for SSH tunnel to RDS endpoint
    2. Manually Use SQL client to connect to database to create tables and import seed data. TOTO: Created database from snapshot.
5. Request Amazon TLS Certificate
6. Create Application Load Balancer for public subnets
7. Create S3 Bucket for environment file
8. Create IAM Assumed Role for ECS Task execution
9. Create ECS Cluster, Task Definition, and Service
10. Create Auto Scaling Group
11. Add DNS record to Route 53
