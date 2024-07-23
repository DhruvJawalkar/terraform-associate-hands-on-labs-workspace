terraform {
  required_version = ">= 1.0.0"
  backend "local" {
    path = "terraform.tfstate"
  }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}