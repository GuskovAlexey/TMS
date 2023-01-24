terraform {
  backend "s3" {
    bucket = "dos11-terraform-state"
    key = "dev/project/terraform.tfstate"
    region = "eu-central-1"
  }

}

# data "aws_availability_zones" "available" {
#   state = "available"
# }

# locals {
#   az_count = length(data.aws_availability_zones.available.names)
#   subnet_type = ["public", "private", "database"]
#   bits = ceil(log(local.az_count * length(local.subnet_type), 2))

#   subnets_cidr_blocks = {
#     for i, name in local.subnet_type :
#         "${name}" => [
#             for subnet_num in range(i * local.az_count, (i + 1) * local.az_count) :
#                 cidrsubnet(var.cidr_block, local.bits, subnet_num)
#         ]
#       }
# }

module "network" {
  source = "../modules/network"
  
  vpc_name = "Dos-11"
  cidr_block = "10.0.0.0/16"

  azs                   = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnet_cidrs   = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  database_subnet_cidrs = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]

  # private_subnet_cidrs  = local.subnets_cidr_blocks.private_subnets
  # public_subnet_cidrs   = local.subnets_cidr_blocks.public_subnets
  # database_subnet_cidrs = local.subnets_cidr_blocks.database_subnets
}

module "app" {
  source = "../modules/app"
  
  vpc_id = module.network.vpc_id
  subnet_id_front = module.network.public_subnet_ids[0]
  subnet_id_back = module.network.private_subnet_ids[1]
  subnet_id_database = module.network.database_subnet_ids[2]

  depends_on = [ module.network ]
} 