terraform plan -generate-config-out=generated_resource.tf
terraform import aws_instance.example <instance-id>