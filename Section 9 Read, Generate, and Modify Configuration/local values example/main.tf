locals {
  service_name = "Automation"
  app_team     = "Cloud Team"
  createdby    = "terraform"
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Name      = var.server_name
    Owner     = local.team
    App       = local.application
    Service   = local.service_name
    AppTeam   = local.app_team
    CreatedBy = local.createdby
 } 
}

module "server" {
  source    = "./server"
  ami       = "ami-06c68f701d8090592"
  subnet_id = aws_subnet.public_subnets["public_subnet_1"].id
}