output "instance_public_ip" {
  value       = aws_instance.my-ec2.public_ip
  description = "Public IP address of the instance."

}
