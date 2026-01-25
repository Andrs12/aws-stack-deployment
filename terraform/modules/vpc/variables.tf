variable "project_name" {
  description = "The name of the project to which the VPC belongs"
  type        = string
}

variable "environment" {
  description = "Environment (dev/prod)"
  type        = string

  validation {
    condition = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
    description = "List of availability zones"
    type        = list(string)
}

variable "public_subnet_cidrs" {
    description = "List of CIDR blocks for public subnets"
    type        = list(string)
}

variable "private_subnet_cidrs" {
    description = "List of CIDR blocks for private subnets"
    type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type = bool
  default = true
}

variable "single_nat_gateway" {
  description = "Use single NAT Gateway (cost optimization for dev)"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
    description = "Enable DNS hostnames in the VPC"
    type = bool
    default = true
}

variable "enable_dns_support" {
    description = "Enable DNS support in the VPC"
    type = bool
    default = true
}

variable "tags" {
    description = "A map of tags to assign to the resources"
    type        = map(string)
    default     = {}
}