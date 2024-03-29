resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "Internet-Gateway"
  }
}

resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.igw]
  domain     = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  depends_on    = [aws_internet_gateway.igw]
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "nat-gw"
  }
}