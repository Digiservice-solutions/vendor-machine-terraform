terraform-init: 
	terraform init -backend-config="../../environments/stage/networking/backend-config.tfvars"

terraform-apply: 
	terraform apply -var-file="../../environments/stage/networking/terraform.tfvars"

terraform-destroy:  
	terraform destroy -var-file="../../environments/stage/networking/terraform.tfvars"