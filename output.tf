output "name" {
  value = aws_instance.ec2_instance.tags.Name
}
output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
output "url" {
    description = "Browser URL to access the Nginx container"
    value = "http://${aws_instance.ec2_instance.public_ip}"
}