# vendor-machine-terraform
Repository for Terraform code to expose vendor-machine functions.

![alt text](image.png)

Prerequisites
- Terraform ≥ 1.0
- AWS CLI configured with credentials
- S3 backend for state management

IAM policies:
- AmazonECS_FullAccess
- AmazonAPIGatewayAdministrator
- SSH key pair for bastion access

Deployment
- First time you run the environment, initialize the project with the Makefile of "init" folder to manage Terraform state.
- Use "terraform init"  initializes the Terraform working directory and then "terraform apply" to apply changes to the infrastructure. Use the commands from the Makefile in each infrastructure folder in the right order.
- Order: 
(1) IAM
(2) Networking
(3) Compute
(4) Integration

Test
Save compute and integration outputs. 
To test public services simply use postman with GET/POST requests to api_gateway_invoke_url/beverages (integration output)
To test the private service
1. Load the key file on the bastion host:
    scp -i test_key.pem test_key.pem ec2-user@bastion_public_dns:~ (Note: bastion_public_dns is in the compute output)
2. Connect to the Bastion Host
    ssh -i test_key.pem ec2-user@bastion_public_dns
3. Change key permissions
    chmod 400 test_key.pem
4. Connect to private ec2
    ssh -i test_key.pem ec2-user@private_ec2_private_ip (Note: private_ec2_private_ip is in the compute output)
5. Use curl to make the request
    curl -X GET ecs_service_discovery_url/ingredients (Note: ecs_service_discovery_url is in the compute output)
