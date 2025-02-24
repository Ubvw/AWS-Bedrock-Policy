provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Ensures we use a 5.x version of the AWS provider
    }
  }
  required_version = ">= 1.0.0"  # Minimum required Terraform version
}