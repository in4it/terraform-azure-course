# Setup Remote state

# Sign in
```
az login
```

# Create recoursegroup for Terraform state
```
az group create -l westeurope -n terraform-state 
```

# Create storage account
*Name must be unique across Azure*

```
az storage account create -g terraform-state -l westeurope \
  --name tfstoragetrainingjorn \
  --sku Standard_LRS \
  --encryption-services blob
```

# List account key & Create storage container

```
az storage account keys list --resource-group terraform-state --account-name tfstoragetrainingjorn --query [0].value -o tsv
az storage container create --name terraform-state-container --account-name tfstoragetrainingjorn --account-key REPLACE_WITH_ACCOUNT_KEY
```
# Create vault key

```
az keyvault create -g terraform-state -l westeurope --name tfkeytrainingjorn
```

# List account key & Create vault key secret 
```
az storage account keys list --resource-group terraform-state --account-name tfstoragetrainingjorn --query [0].value -o tsv
az keyvault secret set --name tfstate-storage-key --value REPLACE_WITH_ACCOUNT_KEY --vault-name tfkeytrainingjorn
```

# Edit main.tf(backend section)

```
Since storage account names need to be unique don't forget to edit the backend section in the main.tf accordinly to your situation
```

# Init terraform to use remote state
```
terraform init
```

# Generate ssh key
```
ssh-keygen -t rsa -b 4096 -f mykey
```

# Run Terraform apply
```
terraform apply
```

# Inspect Terraform state
```
terraform state list
terraform state show azurerm_virtual_machine.demo-instance
```

# Cleanup Demo
```
terraform destroy
az group delete --name terraform-state --no-wait
```

