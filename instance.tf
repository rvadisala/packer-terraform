resource "aws_instance" "nginx_inst" {
  ami                    = var.AMI_ID_PACKER
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main-public-1.id
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow-ssh-http.id]
}

output "Public_IP" {
  value = aws_instance.nginx_inst.public_ip
}


