# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#Retrieve the AWS region
data "aws_region" "current" { }

#Define the VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = var.vpc_name
    Environment = "demo_environment"
    Terraform   = "true"
    Region      = data.aws_region.current.name

  }
}

#Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}

#Deploy the private subnets
resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]

  tags = {
    Name      = each.key
    Terraform = "true"
  }
}

# Terraform Data Block - Lookup Ubuntu 22.04
data "aws_ami" "ubuntu_22_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.ubuntu_22_04.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_subnets["private_subnet_1"].id
  tags = {
    Name = "Web EC2 Server"
  }
}