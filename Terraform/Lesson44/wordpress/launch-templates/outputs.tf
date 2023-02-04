output "ami_frontend" {
  value = data.aws_ami.wordpress_front.id
}

output "ami_backend" {
  value = data.aws_ami.wordpress_back.id
}