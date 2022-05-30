# Internet VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main_vpc"
  }
}

# Subnets
resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2a"

  tags = {
    Name = "public-1"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.10.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2b"

  tags = {
    Name = "public-2"
  }
}

resource "aws_subnet" "public-3" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.10.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2c"

  tags = {
    Name = "public-3"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.10.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2a"

  tags = {
    Name = "private-1"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.10.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2b"

  tags = {
    Name = "private-2"
  }
}

resource "aws_subnet" "private-3" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.10.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2c"

  tags = {
    Name = "private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main-gw"
  }
}

# route tables
resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "route-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.route-public.id
}

resource "aws_route_table_association" "main-public-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.route-public.id
}

resource "aws_route_table_association" "main-public-3" {
  subnet_id      = aws_subnet.public-3.id
  route_table_id = aws_route_table.route-public.id
}
