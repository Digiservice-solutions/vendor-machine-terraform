# Terraform IAM Module

## Overview
This module handles AWS Identity and Access Management (IAM) resources required for the infrastructure. Centralizes IAM role and policy management following least privilege principles.

## Resources Created
- **ECS Task Execution Role** (`ecsExecutionRole`)
  - Allows ECS tasks to call AWS APIs
  - Attaches managed policy `AmazonECSTaskExecutionRolePolicy`
- **Policy Attachment**
  - Links execution role to standard ECS policy

## Input Variables
| Variable | Description                      | Default     | Required |
|----------|----------------------------------|-------------|----------|
| `region` | AWS region for resource creation | `us-west-2` | Yes      |

## Usage
1. See Makefile