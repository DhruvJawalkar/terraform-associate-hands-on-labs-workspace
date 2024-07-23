terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket = "my-terraform-state-djawalkar"
    key = "prod/infra"
    region = "us-east-1"
    dynamodb_table = "sample"
    encrypt = true
  }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}