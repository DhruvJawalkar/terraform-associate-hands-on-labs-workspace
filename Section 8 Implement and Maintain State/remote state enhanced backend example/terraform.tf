terraform {
  required_version = ">= 1.0.0"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "my-successful-organization"

    workspaces {
      name = "my-aws-app"
    }
  }
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