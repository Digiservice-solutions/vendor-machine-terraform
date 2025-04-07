
variable "env_name" {
    description = "The name of the environment"
    type = string
}

variable "region" {
    description = "The region where resources has been deployed"
    type = string
}

variable "vpc_name" {
    description = "The name of the environment"
    type = string
}

variable "cidr_block" {
    description = "The class of cidr block"
    type = string
    default = "10.0.0.0/16"
}

variable "private_subnet_1" {
  type = object({
    cidr_block          = string
    availability_zone   = string
    name                = string
    create_route_table  = bool
  })
  description = "Configurations for private_subnet_1"
}

variable "private_subnet_2" {
  type = object({
    cidr_block          = string
    availability_zone   = string
    name                = string
    create_route_table  = bool
  })
  description = "Configurations for private_subnet_1"
}

variable "public_subnet_1" {
  type = object({
    cidr_block          = string
    availability_zone   = string
    name                = string
    nat_gateway_names   = string
  })
  description = "Configurations for public_subnet_1"
}

variable "public_subnet_2" {
  type = object({
    cidr_block          = string
    availability_zone   = string
    name                = string
    nat_gateway_names   = string
  })
  description = "Configurations for public_subnet_2"
}