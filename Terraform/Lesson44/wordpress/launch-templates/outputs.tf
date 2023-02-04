output "ami_frontend" {
<<<<<<< HEAD
  value = data.aws_ami.wordpress_front.id
}

output "ami_backend" {
  value = data.aws_ami.wordpress_back.id
=======
  value = data.aws_ami.frontend.id
}

output "ami_backend" {
  value = data.aws_ami.backend.id
>>>>>>> a9ee19dc482fb044d7d9c7cefb2ad85565b944b5
}