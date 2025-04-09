terraform-init: 
	terraform init -backend-config="../../environments/stage/iam/backend-config.tfvars"

terraform-apply: 
	terraform apply -var-file="../../environments/stage/iam/terraform.tfvars"

terraform-destroy:  
	terraform destroy -var-file="../../environments/stage/iam/terraform.tfvars"