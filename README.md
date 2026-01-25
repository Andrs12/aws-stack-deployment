
---

## 🛠️ Tech Stack

### Infrastructure & DevOps
- **IaC**: Terraform 1.6+ (AWS Provider 5.x)
- **Configuration Management**: Ansible 2.15+
- **CI/CD**: GitLab CI
- **Cloud Provider**: AWS (Free Tier)
- **Containers**: Docker
- **Monitoring**: AWS CloudWatch

### AWS Services
- **Networking**: VPC, Subnets, Internet Gateway, NAT Gateway, Route Tables
- **Compute**: EC2 (t3.micro), Application Load Balancer
- **Database**: RDS PostgreSQL (db.t3.micro)
- **Storage**: S3 (static assets)
- **Security**: Security Groups, IAM Roles
- **Monitoring**: CloudWatch Logs, CloudWatch Metrics

### Application
- **Backend**: Node.js 18+ / Express.js
- **Frontend**: Angular 17+
- **Database**: PostgreSQL 15
- **Web Server**: Nginx (reverse proxy)

---

## ✨ Features

### Production-Ready Characteristics
- ✅ **Multi-AZ Deployment**: High availability across 2 availability zones
- ✅ **Zero-Downtime Deployments**: Ansible rolling updates with health checks
- ✅ **Dynamic Inventory**: Auto-discovery of EC2 instances via AWS tags
- ✅ **Infrastructure as Code**: 100% reproducible with Terraform
- ✅ **Remote State Management**: S3 backend with DynamoDB locking
- ✅ **Security Best Practices**: 
  - Least-privilege IAM roles
  - Security Groups with minimal access
  - Private subnets for app/database layers
  - Bastion host for SSH access
- ✅ **Cost Optimization**:
  - Single NAT Gateway for dev (~$32/month)
  - S3 Gateway Endpoint (free, saves NAT costs)
  - AWS Free Tier eligible resources
- ✅ **Monitoring**: CloudWatch metrics and logs
- ✅ **Automated CI/CD**: GitLab pipeline for build → test → deploy

---

## 📦 Prerequisites

### Required Tools
```bash
# AWS CLI
aws --version  # >= 2.13.0

# Terraform
terraform --version  # >= 1.6.0

# Ansible
ansible --version  # >= 2.15.0

# Docker
docker --version  # >= 24.0.0

# Git
git --version  # >= 2.40.0
