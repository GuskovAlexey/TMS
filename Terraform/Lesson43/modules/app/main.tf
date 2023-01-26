
resource "aws_instance" "instance_front" {
  count         = "${var.ec2_count_front}"
  ami           = "${var.ec2_ami_front}"
  instance_type = "${var.ec2_type_front}"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg_frontend.id]
  subnet_id =  "${var.subnet_id_front}"
  depends_on = [aws_security_group.sg_frontend]
  key_name = "${var.key_pairs_ec2}"

  provisioner "local-exec" {
    working_dir = "../ansible/"
    command = "sleep 30 && ansible-playbook nginx_front.yaml -i '${self.public_ip},' -u ubuntu --ssh-common-args='-o StrictHostKeyChecking=no' --private-key ~/.ssh/aws-key.pem"
  }

  tags = {
    Name = "Front Instance"
  }
}

data "aws_instance" "front_instance_pub_ip" {
  filter {
    name   = "tag:Name"
    values = ["Front Instance"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  depends_on = [ aws_instance.instance_front ]
}



resource "aws_instance" "instance_back" {
  count         = "${var.ec2_count_back}"
  ami           = "${var.ec2_ami_back}"
  instance_type = "${var.ec2_type_back}"
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.sg_backend.id]
  subnet_id =  "${var.subnet_id_back}"
  key_name = "${var.key_pairs_ec2}"
  depends_on = [aws_security_group.sg_backend, aws_instance.instance_front]

  connection {
    type     = "ssh"
    bastion_host = data.aws_instance.front_instance_pub_ip.public_ip
    bastion_user = "ubuntu"
    bastion_private_key = file("~/.ssh/aws-key.pem")
    user     = "ubuntu"
    private_key = file("~/.ssh/aws-key.pem")
    host     = self.private_ip
  }

  provisioner "local-exec" {
    working_dir = "../ansible/"
    command = "sleep 30 && ansible-playbook nginx_back.yaml -i '${self.public_ip},' -u ubuntu --ssh-common-args='-o StrictHostKeyChecking=no' --private-key ~/.ssh/aws-key.pem"
  }

  tags = {
    Name = "Back Instance"
  }
}

resource "aws_instance" "instance_db" {
  count         = "${var.ec2_count_db}"
  ami           = "${var.ec2_ami_db}"
  instance_type = "${var.ec2_type_db}"
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.sg_database.id]
  subnet_id =  "${var.subnet_id_database}"
  depends_on = [aws_security_group.sg_backend]
  key_name = "${var.key_pairs_ec2}"

  tags = {
    Name = "Db Instance"
  }
}

resource "aws_security_group" "sg_frontend" {
  name        = "sg_frontend"
  description = "Security group for the frontend instances"
  vpc_id = "${var.vpc_id}"
 
  dynamic "ingress" { 
    for_each = ["80", "443", "22"] 
    content { 
      from_port   = ingress.value 
      to_port     = ingress.value 
      protocol    = "tcp" 
      cidr_blocks = ["0.0.0.0/0"] 
    } 
  } 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    Name = "Front SG"
  }
}
resource "aws_security_group" "sg_backend" {
  name        = "backend"
  description = "Security group for the backend instances"
  vpc_id = "${var.vpc_id}"

  dynamic "ingress" { 
    for_each = ["8080", "22"] 
    content { 
      from_port   = ingress.value 
      to_port     = ingress.value 
      protocol    = "tcp" 
      security_groups = [ aws_security_group.sg_frontend.id ]
    } 
  } 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    Name = "Back SG"
  }
}

resource "aws_security_group" "sg_database" { 
  name   = "Database sg" 
  description = "Security group for the database instances"
  vpc_id = "${var.vpc_id}"
    
  ingress { 
    from_port   = 5432 
    to_port     = 5432
    protocol    = "tcp" 
    security_groups = [ aws_security_group.sg_backend.id ] 
  } 
   ingress { 
    from_port   = 22 
    to_port     = 22 
    protocol    = "tcp" 
    security_groups = [ aws_security_group.sg_frontend.id ] 
  } 

  egress { 
    from_port   = 0 
    to_port     = 0 
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"] 
  } 
  
  tags = { 
    Name  = "Database sg" 
  } 
}
