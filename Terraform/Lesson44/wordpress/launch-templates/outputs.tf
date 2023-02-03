output "ami_frontend" {
  value = data.aws_ami.frontend.id
}

output "ami_backend" {
  value = data.aws_ami.backend.id
}