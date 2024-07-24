output "public_ip" {
  description = "This is the public IP of my web server"
  value = aws_instance.web_server.public_ip
}

output "ec2_instance_arn" {
  value = aws_instance.web_server.arn
  sensitive = true
}