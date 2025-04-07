

variable "vpc_id" {
  type = string
  description = "Configurations for private subnet"
}

variable "nat_gateway_id" {
  type = string
  description = "Id of the nat gateway"
}

variable "private_subnet" {
  type = object({
    cidr_block          = string
    availability_zone   = string
    name                = string
    create_route_table  = bool
  })
  description = "Configurations for private subnet"
}















