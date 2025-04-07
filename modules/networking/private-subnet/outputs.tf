output "private_subnet_id" {
  description = "Ids list for private subnet"
  value       = aws_subnet.private-subnet.id
}

output "private_subnet_cidrs" {
  description = "Cidrs list for private subnet"
  value       = aws_subnet.private-subnet.cidr_block
}

