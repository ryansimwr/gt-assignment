# VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "core-vpc"
  }
}
 
 # Public subnets
resource "aws_subnet" "public" {
  count = length(var.subnet_cidr_public)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr_public[count.index]
  map_public_ip_on_launch = true          # public subnet
  availability_zone       = var.subnet_az_public[count.index]

  tags = {
    Name = "subnet-public${count.index + 1}"
  }
} 

# Private subnet
resource "aws_subnet" "private" {
  count = length(var.subnet_cidr_private)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr_private[count.index]
  map_public_ip_on_launch = false         # private subnet
  availability_zone       = var.subnet_az_private[count.index]

  tags = {
    Name = "subnet-private${count.index + 1}"
  }
}