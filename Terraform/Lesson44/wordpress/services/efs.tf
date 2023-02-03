resource "aws_efs_file_system" "efs" {
  creation_token = "wordpress"
}

resource "aws_security_group" "allow_efs" {
  name        = "allow_efs"
  description = "allow_efs"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_efs"
  }
}

resource "aws_efs_mount_target" "private_target" {
  count = local.az_count
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = data.terraform_remote_state.network.outputs.private_subnets[count.index]
  security_groups = [ aws_security_group.allow_efs.id ]
}