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

variable "efs_address" {
    type = string
}

variable "rds_address" {
    type = string
}

variable "db_name" {
    type = string
}
variable "db_user" {
    type = string
}
variable "db_pass" {
    type = string
}

