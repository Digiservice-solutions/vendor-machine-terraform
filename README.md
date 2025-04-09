# vendor-machine-terraform
Repository for Terraform code to expose vendor-machine functions. 

Prerequisites
- Terraform ≥ 1.0
- AWS CLI configured with credentials
- S3 backend for state management

IAM policies:
- AmazonECS_FullAccess
- AmazonAPIGatewayAdministrator
- SSH key pair for bastion access

Deployment
- See Makefile in "infrastructure" folder
- Order: (1) Networking, (2) Compute, (3) Integration