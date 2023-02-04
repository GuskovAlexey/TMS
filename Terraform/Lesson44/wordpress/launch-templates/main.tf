data "aws_ami" "wordpress_back" {
  filter {
    name   = "tag:Name"
    values = ["tms-wordpress-back-tepmlate"]
  }
}

data "aws_ami" "wordpress_front" {
  filter {
    name   = "tag:Name"
    values = ["tms-wordpress-front-tepmlate"]
  }
}

data "aws_security_group" "ssh_from_bastion" {
  tags = {
    Name = "allow_ssh_from_bastion"    
  }
}

data "aws_key_pair" "key_name" {
  key_name = "dos11-aws"
}

resource "aws_launch_template" "front_lt" {
  name = "front-template"
  image_id = data.aws_ami.wordpress_front.id
  instance_type = "t2.micro"
  key_name = data.aws_key_pair.key_name.key_name
  vpc_security_group_ids = [ data.aws_security_group.ssh_from_bastion.id ]  

<<<<<<< HEAD
=======
  tag {
    key = "Name"
    value = "front-template"
  }
>>>>>>> a9ee19dc482fb044d7d9c7cefb2ad85565b944b5
}

resource "aws_launch_template" "back_lt" {
  name = "back-template"
  image_id = data.aws_ami.wordpress_back.id
  instance_type = "t2.micro"
  key_name = data.aws_key_pair.key_name.key_name
  vpc_security_group_ids = [ data.aws_security_group.ssh_from_bastion.id ]  

<<<<<<< HEAD
=======
  tag {
    key = "Name"
    value = "back-template"
  }
>>>>>>> a9ee19dc482fb044d7d9c7cefb2ad85565b944b5
}