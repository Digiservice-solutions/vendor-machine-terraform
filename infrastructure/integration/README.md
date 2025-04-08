# Terraform Integration Module

## Overview
Configures API Gateway integration with backend services via VPC Link.

## Key Components
- **HTTP API Gateway** with routes
- **VPC Link** connecting to private NLB
- **API Integrations** mapping to NLB listener
- **Default stage** with auto-deployment

## Dependencies
- Network Load Balancer from Compute module
- Private subnets from Networking module
- ECS service security group

## Input Variables
| Variable | Description | Default     |
|----------|-------------|-------------|
| `region` | AWS region  | `us-west-2` |

## Configuration Details
- Routes configured:
  - `GET /beverages`
  - `POST /beverages`
- VPC Link uses private subnets and ECS security group
- API Gateway proxies all requests to NLB

## Usage
0. Start Networking part
1. Start Compute part
2. See Makefile