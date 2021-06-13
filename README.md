# terraform-code
Created IAAC which has development and Production Envionment as workspace
For both production and development environment, instance with container is running on it and db server is also configured
If the workspace is set to be "dev" that is development environment then, web and db will built in GCP
and if the workspace is set to be "prod" that is production environment then, web and db will built in AWS.

# For this Ist you have to create terraform workspace on the desired path where the code is present
terraform workspace new dev and terraform workspace new prod
# then select either of the workspace 
terraform workspace select dev or prod
# After selecting workspace, you can run 
terraform init then terraform plan 
# to apply the code
terraform apply

