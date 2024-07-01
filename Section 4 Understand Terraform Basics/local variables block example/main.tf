# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

locals {
  team = "api_mgmt_dev"
  application = "corp_api"
  server_name = "ec2-${var.environment}-api-${var.variables_sub_az}"
  ubuntu_ami_id = "ami-06c68f701d8090592"
}

#Define the VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = var.vpc_name
    Environment = "demo_environment"
    Terraform   = "true"
  }
}

resource "aws_subnet" "variables-subnet" {
vpc_id = aws_vpc.vpc.id
cidr_block = var.variables_sub_cidr
availability_zone = var.variables_sub_az
map_public_ip_on_launch = var.variables_sub_auto_ip
tags = {
Name = "sub-variables-${var.variables_sub_az}"
Terraform = "true"
}
}

resource "aws_instance" "web_server" {
  ami           = local.ubuntu_ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.variables-subnet.id
  tags = {
    Name = local.server_name
    Owner = local.team
    App = local.application
  }
}