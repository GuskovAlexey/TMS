output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private_subnets: subnet.id]
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public_subnets: subnet.id]
}

output "database_subnet_ids" {
  value = [for subnet in aws_subnet.database_subnets: subnet.id]
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "route_table_ids" {
  value = aws_route_table.route_table.id
}