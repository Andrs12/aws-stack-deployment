
# AWS DevOps Production Stack

> Complete infrastructure automation project with CI/CD, multi-AZ deployment, and production-grade practices

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![AWS](https://img.shields.io/badge/AWS-Cloud-orange.svg)](https://aws.amazon.com)

## Description

This project demonstrates a **complete production cloud infrastructure** with full automation and modern DevOps practices. It deploys a scalable three-tier web application using Infrastructure as Code, configuration management, and continuous delivery pipelines.

### Purpose

Built as a **comprehensive DevOps portfolio piece**, this project showcases:

- End-to-end infrastructure automation from network to application layer
- Multi-availability zone architecture with load balancing and failover
- Fully automated CI/CD pipeline for zero-downtime deployments
- Security best practices with network isolation and encrypted communications
- Cost-optimized resource sizing following AWS Well-Architected Framework

The system represents a **real-world production environment** scaled for learning purposes, demonstrating the ability to design, implement, and maintain modern cloud infrastructure through code-driven workflows.

### What It Does

- Provisions complete cloud infrastructure automatically
- Deploys load-balanced application servers across multiple zones
- Manages databases with automated backups and high availability
- Monitors system health with centralized logging and metrics
- Enables automated deployments through continuous delivery pipelines
- Provides disaster recovery through reproducible infrastructure definitions

Every infrastructure and application change follows automated validation, testing, and deployment processes, ensuring consistency and reliability.


## 🏗️ Architecture
![AWS DevOps Stack Architecture](docs/images/arquitecture.png)

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
```
