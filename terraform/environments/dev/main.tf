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