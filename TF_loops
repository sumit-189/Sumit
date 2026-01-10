provider "aws" {
  region = "ap-south-1" # Specify the AWS region
}






resource "aws_instance" "my_instance" {
  for_each = var.instance_type
  ami             = "ami-02b8269d5e85954ef"
  instance_type   = each.value
  key_name        = "mumbai-soheb"
  security_groups = ["default"] # Ensure this security group exists
  # count = 3

  tags = {
    ENV = terraform.workspace
    Name = "My-Terraform-Instance-${each.key}"
  }
}
variable "instance_type"{
  default = {
    small = "t3.small"
    micro = "t3.micro"
  }
}
