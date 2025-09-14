terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the aws provider
provider "aws" {
  region = "us-east-1"
}
