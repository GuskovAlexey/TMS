packer {
  required_plugins {
    amazon = {
      version = " >= 0.0.2 "
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "tms-wordpress-front-tepmlate"
  instance_type = "t2.micro"
  region        = "eu-west-2"
  profile       = "dos-11"
  tags          = {
    Name = "tms-wordpress-front-tepmlate"
  }

  vpc_id  = "${var.vpc_id}"
  subnet_id = "${var.subnet_id_priv}"
  security_group_id = "${var.sg_allow_ssh_from_bastion}"
  ssh_bastion_host = "${var.pub_ip_bastion}"
  ssh_bastion_username = "ubuntu"
  ssh_bastion_private_key_file = "~/.ssh/dos11-aws.pem"
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
        ansible_env_vars = [
          "ANSIBLE_SSH_ARGS='-o PubkeyAcceptedKeyTypes=+ssh-rsa -o HostkeyAlgorithms=+ssh-rsa'"
    ]
        playbook_file = "../../ansible/playbooks/wp_front.yaml"
        extra_arguments = [ "--ssh-extra-args", "-o PubkeyAcceptedKeyTypes=+ssh-rsa","--extra-vars", "nginx_wordpress_conf_wordpress_back_lb_url=${var.nginx_wordpress_conf_wordpress_back_lb_url}"]
    }

    
}