data "terraform_remote_state" "network" {
    backend = "local"

    config = {
        path = "../network/terraform.tfstate"
    }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az_count    = length(data.aws_availability_zones.available.names)
}