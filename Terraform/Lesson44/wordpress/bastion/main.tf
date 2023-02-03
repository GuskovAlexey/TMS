data "terraform_remote_state" "network" {
    backend = "local"

    config = {
        path = "../network/terraform.tfstate"
    }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_key_pair" "key_name" {
  key_name = "dos11-aws"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "SSH from all"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_ssh_from_bastion" {
  name        = "allow_ssh_from_bastion"
  description = "allow_ssh_from_bastion"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = [ aws_security_group.allow_ssh.id ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_from_bastion"
  }
}

resource "aws_instance" "bastion" {
  ami             = data.aws_ami.ubuntu.id
  key_name        = data.aws_key_pair.key_name.key_name
  instance_type   = "t2.micro"
  subnet_id       = data.terraform_remote_state.network.outputs.public_subnets[0]
  security_groups = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true

  tags = {
    Name = "bastionhost"
  }
}
