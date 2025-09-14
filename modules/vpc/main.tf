# VPC
resource "aws_vpc" "mytwotiervpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "two-tier-vpc" }
}

# Internet Gateway
resource "aws_internet_gateway" "mytwotiervpc" {
  vpc_id = aws_vpc.mytwotiervpc.id
  tags   = { Name = "two-tier-igw" }
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnets : cidr => idx }

  vpc_id                  = aws_vpc.mytwotiervpc.id
  cidr_block              = each.key
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, each.value)
  tags = { Name = "public-subnet-${each.key}" }
}

# Private Subnets
resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.private_subnets : cidr => idx }

  vpc_id                  = aws_vpc.mytwotiervpc.id
  cidr_block              = each.key
  map_public_ip_on_launch = false
  availability_zone       = element(data.aws_availability_zones.available.names, each.value)
  tags = { Name = "private-subnet-${each.key}" }
}

# Outputs
output "vpc_id" {
  value = aws_vpc.mytwotiervpc.id
}

output "public_subnets" {
  value = values(aws_subnet.public)[*].id
}

output "private_subnets" {
  value = values(aws_subnet.private)[*].id
}
