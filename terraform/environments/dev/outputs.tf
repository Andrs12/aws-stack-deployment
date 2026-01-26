# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"
  value       = module.vpc.nat_gateway_ids
}

# Compute Outputs
output "alb_dns_name" {
  description = "Load Balancer DNS name"
  value       = module.compute.alb_dns_name
}

output "alb_url" {
  description = "Load Balancer URL"
  value       = "http://${module.compute.alb_dns_name}"
}

output "ec2_instance_ids" {
  description = "EC2 instance IDs"
  value       = module.compute.ec2_instance_ids
}

output "ec2_private_ips" {
  description = "EC2 private IPs"
  value       = module.compute.ec2_private_ips
}

output "bastion_public_ip" {
  description = "Bastion host public IP"
  value       = module.compute.bastion_public_ip
}

# Connection Info
output "ssh_bastion_command" {
  description = "SSH command to connect to bastion"
  value       = module.compute.bastion_public_ip != null ? "ssh -i .ssh/devops-stack-key ec2-user@${module.compute.bastion_public_ip}" : "Bastion disabled"
}

output "ssh_to_ec2_via_bastion" {
  description = "SSH command to connect to EC2 instances via bastion"
  value = module.compute.bastion_public_ip != null ? join("\n", [
    for idx, ip in module.compute.ec2_private_ips :
    "ssh -i .ssh/devops-stack-key -o ProxyCommand=\"ssh -W %h:%p -i .ssh/devops-stack-key ec2-user@${module.compute.bastion_public_ip}\" ec2-user@${ip}"
  ]) : "Bastion disabled"
}