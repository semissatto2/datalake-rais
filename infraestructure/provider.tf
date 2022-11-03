provider "aws" {
  region = var.aws_region
}

# Centraliza o arquivo de controle de estado do Terraform
terraform {
  backend "s3" {
    bucket = "terraform-state-guilherme-rais" # este bucket precisa ser criado manualmente
    key    = "state/rais/terraform.tfstate"
    region = "us-east-2"
  }
}
