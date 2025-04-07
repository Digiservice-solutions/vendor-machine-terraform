
output "vpc_name" {
  description = "Vpc name"
  value = module.vpc.vpc_name
}

output "vpc_cidr" {
  description = "Vpc cidr"
  value = module.vpc.vpc_cidr
}

output "vpc_id" {
  description = "Vpc id"
  value = module.vpc.vpc_id
}


output "private_subnet_1_cidr" {
  description = "Cidrs list for private subnet"
  value       = module.private_subnet_1.private_subnet_cidrs
}

output "private_subnet_1c_id" {
  description = "Ids list for private subnet"
  value       = module.private_subnet_1.private_subnet_id
}

output "public_subnet_1_cidr" {
  description = "Cidrs list for public subnet"
  value       = module.public_subnet_1.public_subnet_cidrs
}

output "public_subnet_1_id" {
  description = "Cidrs list for public subnet"
  value       = module.public_subnet_1.public_subnet_id
}

