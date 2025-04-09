output "public_subnet_id" {
  description = "Ids list for private subnet"
  value       = aws_subnet.public-subnet.id
}

output "public_subnet_cidrs" {
  description = "Cidrs list for private subnet"
  value       = aws_subnet.public-subnet.cidr_block
}

output "nat_gateway_id" {
  description = "Id of the nat gateway"
  value       = aws_nat_gateway.nat-gateway.id
}