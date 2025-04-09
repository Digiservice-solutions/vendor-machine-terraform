resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"
  tags = {
    Name = "${var.vpc_name}"
    Environment = "${var.env_name}"
  }
  enable_dns_hostnames = true
  enable_dns_support = true
}