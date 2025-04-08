# Terraform Networking Module

## Overview
This Terraform configuration sets up the core networking infrastructure for the AWS environment including VPC, subnets, gateways, and routing.

## Resources Created
- **VPC** with specified CIDR block
- **Internet Gateway** for public subnet internet access
- **Public Subnets** (2) with NAT Gateways
- **Private Subnets** (2) with routes through NAT Gateways
- **Route Tables** for public and private subnets

## Prerequisites
- Terraform 1.0+
- AWS provider configured with proper credentials
- S3 backend configured for state management

## Input Variables
| Variable            | Description                             | Default       |
|---------------------|-----------------------------------------|---------------|
| `region`            | AWS region                              | `us-west-2`   |
| `env_name`          | Environment name (e.g., stage)          |               |
| `cidr_block`        | VPC CIDR block                          | `10.0.0.0/16` |
| `public_subnet_1`   | Configuration for first public subnet   |               |
| `public_subnet_2`   | Configuration for second public subnet  |               |
| `private_subnet_1`  | Configuration for first private subnet  |               |
| `private_subnet_2`  | Configuration for second private subnet |               |

## Usage
1. See Makefile