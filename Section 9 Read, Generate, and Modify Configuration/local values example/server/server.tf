variable "ami" {}
variable "size" {
  default = "t2.micro"
}
variable "subnet_id" {}

resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.size
  subnet_id              = var.subnet_id

  /*
  tags = {
    "Service"     = local.service_name
    "Name"        = "Server from Module"
    "Environment" = "Training"
  }
  */
  tags = locals.common_tags
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "public_dns" {
  value = aws_instance.web.public_dns
}