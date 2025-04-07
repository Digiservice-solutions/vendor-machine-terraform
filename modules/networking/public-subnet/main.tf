
# Public Subnet 
resource "aws_subnet" "public-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet.cidr_block
  availability_zone = var.public_subnet.availability_zone
  map_public_ip_on_launch = true  #Ip pubblico per le istanze della subnet privata
  tags = {
    Name = "${var.public_subnet.name}"
  }
}


#Elastic-Ip
resource "aws_eip" "eip" {
  domain = "vpc"
}


#Nat-Gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.eip.allocation_id
  subnet_id = aws_subnet.public-subnet.id
  tags = {
    Name = "${var.public_subnet.nat_gateway_names}"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.internet_gateway]
}


# Associa la subnet pubblica alla tabella di routing pubblica
resource "aws_route_table_association" "public_route_assoc" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = var.public_route_table.id
}








