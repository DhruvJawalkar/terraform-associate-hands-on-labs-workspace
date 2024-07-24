terraform {
  required_version = ">= 1.0.0"
  /*
  backend "local" {
    path = "terraform.tfstate"
  }
  */
  backend "s3" {
    bucket = "my-terraform-state-djawalkar"
    key    = "dev/aws_infra"
    region = "us-east-1"

    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}