# nat gw
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-1.id
  depends_on    = [aws_internet_gateway.main-gw]
}

# VPC setup for NAT
resource "aws_route_table" "route-private" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "route-private"
  }
}

# route associations private
resource "aws_route_table_association" "main-private-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.route-private.id
}

resource "aws_route_table_association" "main-private-2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.route-private.id
}

resource "aws_route_table_association" "main-private-3" {
  subnet_id      = aws_subnet.private-3.id
  route_table_id = aws_route_table.route-private.id
}
