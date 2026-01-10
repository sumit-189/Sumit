provider "aws" {
  region = "ap-southeast-2"  # Specify the AWS region
}

resource "aws_instance" "my_instance" {
  ami             = "ami-00a51cc7a8cd53e3f"
  instance_type   = "t3.micro"
  key_name        = "SR"
  security_groups = ["default"]  # Ensure this security group exists

  tags = {
    ENV = terraform.workspace
    Name = "My-Terraform-Instance"
  }
}
