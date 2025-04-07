


# Private Subnet 
resource "aws_subnet" "private-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet.cidr_block
  availability_zone = var.private_subnet.availability_zone
  map_public_ip_on_launch = false  # Nessun IP pubblico per istanze nella subnet privata
  tags = {
    Name        = "${var.private_subnet.name}"
  }
}


#In this block we are creating route table linked to nat-gatway only for the subnet that need exit on internet
resource "aws_route_table" "private_route_table" {
  count = var.private_subnet.create_route_table ? 1 : 0
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat_gateway_id
  }
  tags = {
    Name = "${var.private_subnet.name}"
  }
}

resource "aws_route_table_association" "public_route_assoc" {
  count = var.private_subnet.create_route_table ? 1 : 0
  subnet_id = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private_route_table[0].id
}





