terraform {
  backend "s3" {
    bucket = "dos11-terraform-state"
    key = "dev/network/terraform.tfstate"
    region = "eu-central-1"
  }
}

resource "aws_vpc" "main" {
 cidr_block = var.cidr_block
 enable_dns_hostnames = true
 enable_dns_support = true

 tags = {
   Name = "${var.vpc_name}"
 }
}

resource "aws_subnet" "public_subnets" {
 count             = length(var.public_subnet_cidrs)
 vpc_id            = aws_vpc.main.id
 cidr_block        = element(var.public_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 depends_on = [aws_vpc.main]

 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}

resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 depends_on = [aws_vpc.main]

 tags = {
   Name = "Private Subnet ${count.index + 1}"
 }
}

resource "aws_subnet" "database_subnets" {
 count      = length(var.database_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.database_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 depends_on = [aws_vpc.main]

 tags = {
   Name = "Database Subnet ${count.index + 1}"
 }
}

resource "aws_internet_gateway" "igw" {
 vpc_id = aws_vpc.main.id
 depends_on = [aws_vpc.main]

 tags = {
   Name = "Internet Gateway"
 }
}

resource "aws_route_table" "route_table" {
 vpc_id = aws_vpc.main.id
 depends_on = [ aws_vpc.main, aws_internet_gateway.igw]

 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
 }

  tags = {
   Name = "Route Table"
 }
}

resource "aws_route_table_association" "public_subnet_asso" {
 count          = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.route_table.id
 depends_on = [ aws_vpc.main, aws_subnet.public_subnets, aws_route_table.route_table ]
}

#========================  NAT from public subnet =================
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_route_table_association" "private_subnet_asso" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private.id
  depends_on = [ aws_vpc.main, aws_subnet.private_subnets, aws_route_table.private ]
}