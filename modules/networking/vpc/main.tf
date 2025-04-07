

# Creazione della VPC
resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"  # Imposta il CIDR block della VPC
  tags = {
    Name = "${var.vpc_name}"           # Tag per identificare la VPC
    Environment = "${var.env_name}"        # Ambiente (può essere dev, staging, prod)
  }
  enable_dns_hostnames = true
  enable_dns_support = true
}