terraform {
  backend "remote" {
    organization = "my-successful-organization"

    workspaces {
      name = "my-aws-app"
    }
  }
}