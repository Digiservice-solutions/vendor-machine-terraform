output "vpc_name" {
  description = "Vpc name"
  value = aws_vpc.vpc.tags.Name
}

output "vpc_cidr" {
  description = "Vpc cidr"
  value = aws_vpc.vpc.cidr_block
}

output "vpc_id" {
  description = "Vpc id"
  value = aws_vpc.vpc.id
}