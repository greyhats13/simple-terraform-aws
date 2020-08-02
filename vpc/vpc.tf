resource "aws_vpc" "this" {
  cidr_block            = var.vpc-cidr-block

  enable_dns_hostnames  = "true"
  enable_dns_support    = "true"

  tags = {
    Name = var.vpc_name
  }
}

#Node Subnet
resource "aws_subnet" "nodes_subnet" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.nodes_subnet_cidr
  availability_zone = "us-east-2a"

  tags = {
    Name = "nodes-subnet-us-east-2a"
  }
}

#Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            =  aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "us-east-2a"

  tags = {
    Name = "public-subnet-us-east-2a"
  }
}


#Internet Gatway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "Internet-Gateway"
  }
}

resource "aws_eip" "eip" {
  count = 1
  vpc = true

  tags = {
    Name = "Elastic IP Nat"
  }
}

# Nat Gateway allocated to elastic ip's
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip.id, count.index)
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "NAT-us-east-2a"
  }
}

#Public Route Table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public RT"
  }
}

#Nodes Route Table
resource "aws_route_table" "node-rt" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "Nodes-RT-us-east-2a"
  }
}

resource "aws_route_table_association" "public_route_assc" {
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "node_route_assc" {
  subnet_id      = aws_subnet.nodes_subnet.id
  route_table_id = aws_route_table.node-rt.id
}