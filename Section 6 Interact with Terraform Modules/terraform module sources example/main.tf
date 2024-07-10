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

resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.generated.private_key_pem
  filename = "MyAWSKey.pem"
}

module "server_subnet_1" {
  source      = "./modules/web_server"
  ami         = "ami-06c68f701d8090592"
  key_name    = "MyAWSKey.pem"
  user        = "ubuntu"
  private_key = tls_private_key.generated.private_key_pem
  subnet_id   = aws_subnet.public_subnets["public_subnet_1"].id
}

output "public_ip" {
  value = module.server_subnet_1.public_ip
}

output "public_dns" {
  value = module.server_subnet_1.public_dns
}

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.7.0"

  # Autoscaling group
  name = "myasg"

  vpc_zone_identifier = [aws_subnet.public_subnets["public_subnet_1"].id]
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  image_id      = "ami-06c68f701d8090592"
  instance_type = "t3.micro"

}

module "autoscaling_github" {
  source = "github.com/terraform-aws-modules/terraform-aws-autoscaling"

  # Autoscaling group
  name = "myasg"

  vpc_zone_identifier = [aws_subnet.public_subnets["public_subnet_1"].id]
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  image_id      = "ami-06c68f701d8090592"
  instance_type = "t3.micro"

}