variable "tags" {
  type = map
  default = {
    Project = "wordpress"
    Name = "dos11"
    Terraform = true
  }
}

variable "db_name" {
  type = string
  default = "wordpress"
}

variable "db_pass" {
  type = string
  default = "wordpress"
 
}

variable "db_user" {
  type = string
  default = "wordpress"
}