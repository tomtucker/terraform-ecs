# AWS 3-Tier Web Application Infrastructure

## Project Overview

Designed and implemented a fully automated, production-ready Infrastructure as Code (IaC) solution for deploying a scalable 3-tier web application on AWS. This project demonstrates expertise in cloud architecture, containerization, and modern DevOps practices using Terraform to provision and manage enterprise-grade infrastructure.

## Technical Challenge

The project addresses the complexity of deploying a highly available, secure, and scalable web application infrastructure on AWS. It eliminates manual configuration errors, ensures consistency across environments, and provides a repeatable deployment process through infrastructure automation.

## Architecture & Design

### Three-Tier Architecture

**Presentation Layer**
- Application Load Balancer distributing traffic across multiple availability zones
- SSL/TLS encryption via AWS Certificate Manager for secure HTTPS connections
- Route 53 DNS management for custom domain configuration
- Public subnets with Internet Gateway for external connectivity

**Application Layer**
- Containerized PHP/Laravel application running on Amazon ECS
- Custom Docker images based on Amazon Linux 2 with Apache and PHP 7.4
- Private subnets for enhanced security
- Auto Scaling Groups for dynamic capacity management
- NAT Gateways for secure outbound internet access

**Data Layer**
- Amazon RDS MySQL database with multi-AZ deployment option
- Isolated private subnets for maximum security
- Automated backups and maintenance windows
- Secure connectivity from application tier only

## Technologies & Tools

**Infrastructure & Cloud**
- **Terraform** - Infrastructure as Code for reproducible deployments
- **AWS VPC** - Custom networking with public and private subnets
- **Amazon ECS** - Container orchestration and management
- **Amazon RDS** - Managed relational database service
- **Application Load Balancer** - Layer 7 load balancing with SSL termination
- **AWS Certificate Manager** - SSL/TLS certificate provisioning
- **Amazon Route 53** - DNS management and routing
- **AWS Auto Scaling** - Automatic capacity management

**Security & Access Management**
- **IAM Roles & Policies** - Least-privilege access control
- **Security Groups** - Network-level traffic filtering
- **NAT Gateways** - Secure outbound connectivity for private resources
- **Amazon S3** - Encrypted storage for environment configurations

**Containerization**
- **Docker** - Application containerization
- **Amazon ECR** - Private container registry

**Application Stack**
- PHP 7.4 with Apache web server
- Laravel framework
- MySQL database

## Key Features & Accomplishments

### High Availability
- Multi-AZ deployment across 2 availability zones
- Load balancing with automatic failover
- Auto-scaling based on demand
- No single point of failure

### Security Best Practices
- Network segmentation with public and private subnets
- Encrypted data in transit (SSL/TLS)
- IAM role-based access control
- Database isolated in private subnet with restricted access
- Security groups implementing defense-in-depth strategy

### Scalability & Performance
- Container-based architecture for easy scaling
- Auto Scaling Groups automatically adjust capacity
- Load balancer efficiently distributes traffic
- Stateless application design

### Infrastructure as Code
- Modular Terraform design for reusability
- Version-controlled infrastructure
- Consistent deployments across environments
- Easy rollback and disaster recovery

### DevOps & Automation
- Fully automated infrastructure provisioning
- Environment-based configuration management
- Repeatable and predictable deployments
- Infrastructure changes tracked in version control

## Technical Implementation

### Modular Architecture
Implemented a modular Terraform codebase with reusable modules for:
- VPC and networking components
- NAT Gateway configuration
- Security groups
- RDS database provisioning
- Load balancer setup
- S3 bucket creation
- IAM roles and policies
- ECS cluster and services
- Auto Scaling configuration
- DNS records

### Configuration Management
- Variables-driven deployment allowing easy customization
- Separate environment configurations via `.tfvars` files
- Environment variables securely stored in S3
- Sensitive data management following AWS best practices

## Skills Demonstrated

- **Cloud Architecture** - Designing scalable, highly available AWS infrastructure
- **Infrastructure as Code** - Terraform expertise for automated provisioning
- **Containerization** - Docker image creation and ECS deployment
- **Networking** - VPC design, subnet planning, routing configuration
- **Security** - Implementing AWS security best practices
- **DevOps** - CI/CD-ready infrastructure automation
- **Database Management** - RDS configuration and management
- **Load Balancing** - ALB setup with SSL termination
- **Auto Scaling** - Dynamic capacity management
- **DNS Management** - Route 53 configuration

## Project Impact

This infrastructure solution provides:
- **99.9%+ availability** through multi-AZ deployment
- **Automated scaling** reducing manual intervention
- **Enhanced security** through network isolation and encryption
- **Cost optimization** via auto-scaling and right-sized resources
- **Rapid deployment** - entire infrastructure provisioned in minutes
- **Consistent environments** - no configuration drift between deployments

## Future Enhancements

- Implement CI/CD pipeline for automated application deployment
- Add CloudWatch monitoring and alerting
- Integrate AWS WAF for application-layer protection
- Implement blue-green deployment strategy
- Add Aurora database for improved performance
- Implement cross-region disaster recovery

---

**Repository:** [github.com/tomtucker/terraform-ecs](https://github.com/tomtucker/terraform-ecs)

**Technologies:** Terraform, AWS (VPC, ECS, RDS, ALB, Route 53, S3, IAM, ACM), Docker, PHP, Laravel, MySQL
