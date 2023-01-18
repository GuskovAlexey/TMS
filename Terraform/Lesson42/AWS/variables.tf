
variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_profile" {
  default = "default"
}

variable "vpc_name" {
  type = string
  default = "Doss-11"
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "ec2_count_front" {
  type = string
  default = "1"
}

variable "ec2_count_back" {
  type = string
  default = "2"
}

variable "ec2_type_front" {
  type = string
  default = "t2.micro"
}

variable "ec2_type_back" {
  type = string
  default = "t2.micro"
}

variable "ec2_ami" {
  type = string
  default = "ami-0a261c0e5f51090b1"
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