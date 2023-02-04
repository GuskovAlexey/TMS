
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnets_cidr_blocks" {
  value = local.subnets_cidr_blocks
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}
####### output to packer ##################
output "subnet_id_priv" {
  value = module.vpc.private_subnets[0]
}
output "subnet_id_pub" {
  value = module.vpc.public_subnets[0]
}



