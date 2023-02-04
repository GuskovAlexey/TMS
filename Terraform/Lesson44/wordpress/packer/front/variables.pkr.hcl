variable "vpc_id" {
    type = string
}

variable "subnet_id_priv" {
    type = string
}

variable "sg_allow_ssh_from_bastion" {
    type = string
}

variable "pub_ip_bastion" {
    type = string
}


variable "nginx_wordpress_conf_wordpress_back_lb_url" {
    type = string
}

