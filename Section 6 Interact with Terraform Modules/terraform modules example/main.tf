# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

#Define the VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = var.vpc_name
    Environment = "demo_environment"
    Terraform   = "true"
  }
}

#Deploy the public subnets
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone       = tolist(data.aws_availability_zones.available.names)[each.value]
  map_public_ip_on_launch = true

  tags = {
    Name      = each.key
    Terraform = "true"
  }
}

module "server" {
  source          = "./server"
  ami             = "ami-06c68f701d8090592"
  subnet_id       = aws_subnet.public_subnets["public_subnet_1"].id
}

output "public_ip" {
  value = module.server.public_ip
}

output "public_dns" {
  value = module.server.public_dns
}

#sample reuse of module to create the same resource in a different subnet, "public_subnet_2"
//module "server_subnet_2" {
//  source          = "./server"
//  ami             = "ami-06c68f701d8090592"
//  subnet_id       = aws_subnet.public_subnets["public_subnet_2"].id
//}