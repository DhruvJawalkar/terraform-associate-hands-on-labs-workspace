terraform {
  required_version = ">= 1.0.0"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "my-successful-organization"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}