# Terraform

1. Terraform Init
    
    a. Local Setup
    ```
    terraform init
    ```
    b. S3 backemd setup with tfvars file
    ```
    terraform init -backend-config backend.tfvars
    ```

2. Terraform Plan
```
terraform plan -var-file variables.tfvars
```

3. Terraform Apply
```
terraform apply -var-file variables.tfvars -auto-approve
```

## Goals for This Project
- [x] Setup Terraform locally
- [ ] Try some things

