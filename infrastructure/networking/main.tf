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

#----Definizione della Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = module.vpc.vpc_id
  # Route per instradare il traffico verso Internet (0.0.0.0/0) tramite il gateway Internet
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



