provider "aws" {
  region = "us-east-1"  # Change this to your desired region
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