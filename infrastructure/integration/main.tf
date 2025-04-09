provider "aws" {
  region = var.region
}

#Remote Backend for the networking component in stage environment
terraform {
  backend "s3" {}
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc_vendor_machine_test"]
  }
}

data "aws_subnet" "private_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["private_subnet_1"]
  }
}

data "aws_subnet" "private_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["private_subnet_2"]
  }
}

data "aws_security_group" "ecs_sg" {
  name = "ecs-sg"
}

data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    bucket = "bucket-terraform-state-digi-v3"
    key    = "vending-machine-test/stage/compute/terraform.tfstate"
    region = "us-west-2"
  }
}

#1: API Gateway
resource "aws_apigatewayv2_api" "api" {
  name          = "vendor-machine-api-gateway"
  protocol_type = "HTTP"
}

#2: VPC Link
resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               = "development-vpclink"
  security_group_ids = [data.aws_security_group.ecs_sg.id]
  subnet_ids         = [data.aws_subnet.private_subnet_1.id,data.aws_subnet.private_subnet_2.id]
}

#3: API Integration
resource "aws_apigatewayv2_integration" "api_integration" {
  api_id           = aws_apigatewayv2_api.api.id
  integration_type = "HTTP_PROXY"
  integration_uri    = data.terraform_remote_state.compute.outputs.hello_world_listener_arn
  connection_type  = "VPC_LINK"
  connection_id    = aws_apigatewayv2_vpc_link.vpc_link.id
  integration_method = "ANY"
}

#4: APIGW Route
resource "aws_apigatewayv2_route" "default" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /beverages"
  target    = "integrations/${aws_apigatewayv2_integration.api_integration.id}"
}

#4: APIGW Route
resource "aws_apigatewayv2_route" "post_beverage_route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "POST /beverages"
  target    = "integrations/${aws_apigatewayv2_integration.api_integration.id}"
}

#5: APIGW Stage
resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}