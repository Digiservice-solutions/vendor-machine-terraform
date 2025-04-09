variable "vpc_id" {
    description = "The vpc id where the subnet is located"
    type = string
}

variable "internet_gateway" {
  description = "Reference to the Internet Gateway resource"
  type        = any
}

variable "public_route_table" {
  description = "Reference to the Public route table"
  type        = any
}


variable "public_subnet" {
  type = object({
    cidr_block          = string
    availability_zone   = string
    name                = string
    nat_gateway_names   = string
  })
  description = "Configurations for public subnet"
}