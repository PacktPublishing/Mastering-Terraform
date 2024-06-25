terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
  backend "s3" {
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.primary_region
}

