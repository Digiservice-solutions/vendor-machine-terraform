terraform-init: 
	terraform init -backend-config="../../environments/stage/integration/backend-config.tfvars"

terraform-apply: 
	terraform apply -var-file="../../environments/stage/integration/terraform.tfvars"

terraform-destroy:  
	terraform destroy -var-file="../../environments/stage/integration/terraform.tfvars"