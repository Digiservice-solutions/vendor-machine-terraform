
env_name = "stage"
vpc_name = "vpc_vendor_machine_test"
cidr_block = "10.0.0.0/16"
region = "us-west-2"


private_subnet_1 = {
    name = "private_subnet_1"
    cidr_block = "10.0.0.0/19"
    availability_zone = "us-west-2a"
    create_route_table  = true
}

private_subnet_2 = {
    name = "private_subnet_2"
    cidr_block = "10.0.32.0/19"
    availability_zone = "us-west-2b"
    create_route_table  = true
}

public_subnet_1 = {
    name = "public_subnet_1"
    cidr_block = "10.0.64.0/19"
    availability_zone = "us-west-2a"
    nat_gateway_names = "nat-gateway-1"
}

public_subnet_2 = {
    name = "public_subnet_2"
    cidr_block = "10.0.96.0/19"
    availability_zone = "us-west-2b"
    nat_gateway_names = "nat-gateway-2"
}





