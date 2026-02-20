##### Create the network infrastructure #####

## Main VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Project1_vpc_lara"
  }
}

## Puclic subnet 
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = {
    Name = "publicSN_lara"
  }
}


## Private subnet
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zone

  tags = {
    Name = "privateSN_lara"
  }
}

## Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW_lara"
  }
}

## Public Route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id  # Use your IGW name
  }

  tags = {
    Name = "Public_RT_lara"
  }
}

# Route Table for Private Subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private_RT_lara"
  }
}


## NAT Gateway for private network

resource "aws_eip" "eip_nat" {
  domain = "vpc"

  tags = {
    Name = "NAT-EIP-lara" 
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "NAT-Gateway-lara"
  }
  depends_on = [aws_internet_gateway.igw]
}





## Associate public subnet with route table
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate private subnet with Private route table
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}