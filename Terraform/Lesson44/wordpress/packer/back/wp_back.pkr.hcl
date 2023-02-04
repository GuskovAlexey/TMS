packer {
  required_plugins {
    amazon = {
      version = " >= 0.0.2 "
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "tms-wordpress-back-tepmlate"
  instance_type = "t2.micro"
  region        = "eu-west-2"
  profile       = "dos-11"
  tags          = {
    Name = "tms-wordpress-back-tepmlate"
  }

  vpc_id  = "${var.vpc_id}"
  subnet_id = "${var.subnet_id_priv}"
  security_group_id = "${var.sg_allow_ssh_from_bastion}"
  ssh_bastion_host = "${var.pub_ip_bastion}"
  ssh_bastion_username = "ubuntu"
<<<<<<< HEAD
  ssh_bastion_private_key_file = "~/.ssh/dos11-aws.pem"
=======
  ssh_bastion_private_key_file = "~/.ssh/dos11-aws"
>>>>>>> a9ee19dc482fb044d7d9c7cefb2ad85565b944b5
  # ssh_bastion_agent_auth = true
  ssh_username = "ubuntu"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
}

build {
    sources = [
        "source.amazon-ebs.ubuntu"
    ]

    provisioner "ansible" {
        playbook_file = "../../ansible/playbooks/wp_back.yaml"
        extra_arguments = ["--extra-vars", "efs_address=${var.efs_address} wordpress_db_host=${var.rds_address} wordpress_db_name=${var.db_name} wordpress_db_user=${var.db_user} wordpress_db_pass=${var.db_pass}"]
    }

    
}