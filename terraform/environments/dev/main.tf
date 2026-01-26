# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  project_name         = "devops-stack"
  environment          = "dev"
  vpc_cidr             = "10.0.0.0/16"
  azs                  = ["eu-west-1a", "eu-west-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    CostCenter = "development"
  }
}

# Compute Module
module "compute" {
  source = "../../modules/compute"

  project_name       = "devops-stack"
  environment        = "dev"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  instance_type  = "t3.micro"
  instance_count = 2
  key_name       = "devops-stack-dev-key"

  # Security: Restringir SSH solo a tu IP (cambia esto)
  allowed_ssh_cidr_blocks = ["0.0.0.0/32"] # TODO: Cambiar a tu IP pública

  enable_bastion    = true
  health_check_path = "/health"
  app_port          = 3000
  s3_bucket_name    = "devops-aws-stack-tfstate-1769354257" # Tu bucket actual

  tags = {
    CostCenter = "development"
  }
}