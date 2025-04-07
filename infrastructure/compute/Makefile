terraform-init: 
	terraform init -backend-config="../../environments/stage/compute/backend-config.tfvars"

terraform-apply: 
	terraform apply -var-file="../../environments/stage/compute/terraform.tfvars"

terraform-destroy:  
	terraform destroy -var-file="../../environments/stage/compute/terraform.tfvars"