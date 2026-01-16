resource "aws_security_group" "my-sg" {

  name        = "my-sg2"
  description = "allow all traffic"

  tags = {
    Name = "my-new-sg"
  }
  
  provider "aws" {
  region = "us-east-2"
}





resource "aws_instance" "my-ec2" {
  ami           = var.image-id
  instance_type = var.instance_type
  key_name      = var.my-key
  # security_groups = ["default"]
  vpc_security_group_ids = [aws_security_group.my-sg.id]

  user_data = <<-EOT
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    EOT

  tags = {
    Name = "my-server"
  }

}

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}
