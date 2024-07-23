terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket = "my-terraform-state-djawalkar"
    region = "us-east-1"
  }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}