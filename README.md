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
    c. S3 backemd setup with tfvars file with auto approve if prompted for input
    ```
    terraform init -backend-config backend.tfvars -force-copy
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

