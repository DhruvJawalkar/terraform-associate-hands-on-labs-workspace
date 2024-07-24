terraform {
  required_version = ">= 1.0.0"
  /*
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "my-successful-organization"

    workspaces {
      name = "my-aws-app"
    }
  }
  */
  /*
   backend "s3" {
    bucket = "my-terraform-state-djawalkar"
    key    = "prod/aws_infra"
    region = "us-east-1"

    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
  */

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
}