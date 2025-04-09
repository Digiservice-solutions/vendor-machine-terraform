provider "aws" {
  region = var.region
}

#Remote Backend for the networking component in stage environment
terraform {
  backend "s3" {}
}

#-----------------VPC----------------------------------------
module "vpc" {
  source = "../../modules/networking/vpc"
  env_name = var.env_name
  cidr_block = var.cidr_block
  vpc_name = var.vpc_name
}

#----Internet-Gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id =  module.vpc.vpc_id
  tags = {
    Name = "internet_gateway"
  }
}

#----Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
  tags = {
    Name = "PublicRouteTable"
  }
}

module "public_subnet_1" {
  source = "../../modules/networking/public-subnet"
  public_subnet = var.public_subnet_1
  vpc_id = module.vpc.vpc_id
  internet_gateway = aws_internet_gateway.internet-gateway
  public_route_table = aws_route_table.public_route_table
}

module "public_subnet_2" {
  source = "../../modules/networking/public-subnet"
  public_subnet = var.public_subnet_2
  vpc_id = module.vpc.vpc_id
  internet_gateway = aws_internet_gateway.internet-gateway
  public_route_table = aws_route_table.public_route_table
}

#-----------------Private Subnet-----------------------------
module "private_subnet_1" {
  source = "../../modules/networking/private-subnet"
  private_subnet = var.private_subnet_1
  vpc_id = module.vpc.vpc_id
  nat_gateway_id = module.public_subnet_1.nat_gateway_id
}

module "private_subnet_2" {
  source = "../../modules/networking/private-subnet"
  private_subnet = var.private_subnet_2
  vpc_id = module.vpc.vpc_id
  nat_gateway_id = module.public_subnet_2.nat_gateway_id
}

resource "aws_security_group" "ssh_bastion_ec2_v2" {
  name = "ssh_bastion_ec2_v2"
  description = "Allow SSH access from specific IP"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_private_ec2_v2" {
  name        = "ssh_private_ec2_v2"
  description = "Security group for SSH access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "lb_sg" {
  name   = "lb-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}