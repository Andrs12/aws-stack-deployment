terraform {
  backend "s3" {
    bucket  = "devops-aws-stack-tfstate-1769354257"
    key     = "dev/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}