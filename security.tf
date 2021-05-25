resource "aws_security_group" "allow-ssh-http" {

  vpc_id = aws_vpc.main.id

  name        = "allow-ssh-web"
  description = "Allow SSH and Web Traffic"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    self        = false
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    self        = false
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    self        = false
    to_port     = 80
  }

  tags = {
    Name    = "Aws Main Security Group"
    Project = "Main VPC"
  }

}