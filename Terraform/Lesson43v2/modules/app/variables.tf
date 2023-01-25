variable "ec2_count_front" {
  type = string
  default = "1"
}

variable "ec2_count_back" {
  type = string
  default = "1"
}

variable "ec2_count_db" {
  type = string
  default = "1"
}

variable "ec2_type_front" {
  type = string
  default = "t2.micro"
}

variable "ec2_type_back" {
  type = string
  default = "t2.micro"
}

variable "ec2_type_db" {
  type = string
  default = "t2.micro"
}

variable "ec2_ami_front" {
  type = string
  default = "ami-03e08697c325f02ab"
}

variable "ec2_ami_back" {
  type = string
  default = "ami-03e08697c325f02ab"
}


variable "ec2_ami_db" {
  type = string
  default = "ami-03e08697c325f02ab"
}

variable "key_pairs_ec2" {
  type = string
  default = "aws-key"
}

variable "public_ip_true" {
  type = bool
  default = "true"
}

variable "public_ip_false" {
  type = bool
  default = "false"
}

variable "subnet_id_front" {
  type = string
}

variable "subnet_id_back" {
  type = string
}

variable "subnet_id_database" {
  type = string
}
variable "vpc_id" {
  type = string
}