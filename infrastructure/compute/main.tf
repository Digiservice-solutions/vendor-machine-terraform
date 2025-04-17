provider "aws" {
  region = var.region
}

#Remote Backend for the networking component in stage environment
terraform {
  backend "s3" {}
}

data "aws_security_group" "ssh_private_ec2" {
    name = "ssh_private_ec2_v2"
}

data "aws_security_group" "ssh_bastion_ec2" {
    name = "ssh_bastion_ec2_v2"
}

data "aws_security_group" "ecs_sg" {
  name   = "ecs-sg"
}

data "aws_security_group" "lb_sg" {
  name   = "lb-sg"
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

data "aws_subnet" "public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["public_subnet_1"]
  }
}

data "aws_subnet" "public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["public_subnet_2"]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc_vendor_machine_test"]
  }
}

data "aws_iam_role" "ecs_execution_role" {
  name   = "ecsExecutionRole"
}

# compute/ecs_cluster.tf
resource "aws_ecs_cluster" "cluster" {
  name = "my-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "my-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.aws_iam_role.ecs_execution_role.arn
  task_role_arn            = data.aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "vendor_machine_app"
      image = "178929176661.dkr.ecr.us-east-1.amazonaws.com/vending-machine-test:1.0"
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [data.aws_subnet.private_subnet_1.id,data.aws_subnet.private_subnet_2.id]
    security_groups  = [data.aws_security_group.ecs_sg.id]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.hello_world.id
    container_name   = "vendor_machine_app"
    container_port   = 3000
  }
  service_registries {
    registry_arn = aws_service_discovery_service.my_service_discovery.arn
  }
}

resource "aws_lb" "default" {
  name               = "do4m-lb"
  internal           = true              
  load_balancer_type = "network"
  subnets            = [data.aws_subnet.public_subnet_1.id, data.aws_subnet.public_subnet_2.id]
  security_groups    = [data.aws_security_group.lb_sg.id]
}

resource "aws_lb_target_group" "hello_world" {
  name        = "do4m-target-group"
  port        = 80
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.vpc.id
  target_type = "ip"
}

resource "aws_lb_listener" "hello_world" {
  load_balancer_arn = aws_lb.default.id
  port              = "80"
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.hello_world.id
    type             = "forward"
  }
}

resource "aws_service_discovery_private_dns_namespace" "private_dns" {
  name        = "private-service.local"
  description = "Private DNS namespace for ECS"
  vpc         = data.aws_vpc.vpc.id
}

resource "aws_service_discovery_service" "my_service_discovery" {
  name                 = "my-ecs-service"
  namespace_id         = aws_service_discovery_private_dns_namespace.private_dns.id
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.private_dns.id
    dns_records {
      ttl  = 60
      type = "A"
    }
  }
}

resource "aws_instance" "private_ec2" {
  ami           = "ami-087f352c165340ea1"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.private_subnet_1.id
  key_name      = "test_key"
  associate_public_ip_address = false
  vpc_security_group_ids = [data.aws_security_group.ssh_private_ec2.id]
  tags = {
    Name = "Private-EC2-bis"
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-087f352c165340ea1"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.public_subnet_1.id
  key_name      = "test_key"
  associate_public_ip_address = true
  vpc_security_group_ids = [data.aws_security_group.ssh_bastion_ec2.id]
  tags = {
    Name = "Bastion-Host"
  }
}