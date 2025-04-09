# Terraform Compute Module

## Overview
Deploys application infrastructure including ECS cluster, service, Network Load Balancer, and supporting resources.

## Key Components
- **ECS Cluster** with Fargate task definition
- **Network Load Balancer** (NLB) in public subnets
- **Bastion Host** EC2 instance in public subnet
- **Service Discovery** for private DNS namespace

## Prerequisites
- Existing VPC and subnets (from Networking module)
- Docker image in ECR repository
- SSH key pair for bastion host access

## Input Variables
| Variable    | Description                       | Default     |
|-------------|-----------------------------------|-------------|
| `region`    | AWS region                        | `us-west-2` |
| `ecr_image` | ECR image URI for task definition |             |

## Important Notes
- Security group for ECS allows inbound traffic on port 3000
- NLB is internal-facing (private) by default
- Bastion host has open SSH access (0.0.0.0/0) - restrict in production

## Usage
0. Start Networking part
1. See Makefile