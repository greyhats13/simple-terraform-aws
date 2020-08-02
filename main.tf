provider "aws" {
  region     = "us-east-2"
  profile    = "staging"
}

resource "aws_vpc" "this" {
  cidr_block = "10.43.192.128/25"
                                                                                                                      
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
}

# # #Node Subnet
# resource "aws_subnet" "nodes_subnet" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "10.43.192.128/28"
#   availability_zone = "us-east-2a"

#   tags = {
#     Name = "nodes-subnet-us-east-2a"
#   }
# }

# # #Public Subnet
# resource "aws_subnet" "public_subnet" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "10.43.192.144/28"
#   availability_zone = "us-east-2a"

#   tags = {
#     Name = "public-subnet-us-east-2a"
#   }
# }


# #Internet Gatway
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.this.id

#   tags = {
#     Name = "Internet-Gateway"
#   }
# }

# resource "aws_eip" "eip" {
#   vpc = true

#   tags = {
#     Name = "Elastic IP Nat"
#   }
# }

# # Nat Gateway allocated to elastic ip's
# resource "aws_nat_gateway" "nat-gw" {
#   allocation_id = aws_eip.eip.id
#   subnet_id     = aws_subnet.public_subnet.id

#   tags = {
#     Name = "NAT-us-east-2a"
#   }
# }

# #Public Route Table
# resource "aws_route_table" "public-rt" {
#   vpc_id = aws_vpc.this.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = {
#     Name = "Public RT"
#   }
# }

# #Nodes Route Table
# resource "aws_route_table" "node-rt" {
#   vpc_id = aws_vpc.this.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.nat-gw.id
#   }

#   tags = {
#     Name = "Nodes-RT-us-east-2a"
#   }
# }

# resource "aws_route_table_association" "public_route_assc" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public-rt.id
# }

# resource "aws_route_table_association" "node_route_assc" {
#   subnet_id      = aws_subnet.nodes_subnet.id
#   route_table_id = aws_route_table.node-rt.id
# }

# resource "aws_security_group" "node-sg" {
#   name        = "node-sg"
#   description = "kubectl_instance_sg"
#   vpc_id      = aws_vpc.this.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "node-security-group"
#   }
# }

# resource "tls_private_key" "this" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "this" {
#   key_name   = "deployer-key"
#   public_key = tls_private_key.this.public_key_openssh
# }

# resource "aws_instance" "node" {
#   instance_type          = "t2.micro"
#   ami                    = "ami-0d6bbb3973f07760c"
#   key_name               = aws_key_pair.this.key_name
#   subnet_id              = aws_subnet.nodes_subnet.id
#   vpc_security_group_ids = [aws_security_group.node-sg.id]

#   root_block_device {
#     volume_type           = "gp2"
#     volume_size           = "20"
#     delete_on_termination = "true"
#   }

#   tags = {
#     Name = "ec2-demo"
#   }
# }
