# Setup CosmosDB 

# Sign in
```
az login
```

# Generate ssh key
```
ssh-keygen -t rsa -b 4096 -f mykey
```
# Run Terraform init
```
terraform init
```

# Run Terraform apply
```
terraform apply
```

# Ssh into virtual machine
The output of terraform shows the public ip

```
ssh demo@PUBLIC_IP_HERE-i mykey
```

# Get token and dowload content of blob file

```
curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fstorage.azure.com%2F' -H Metadata:true
```

```
curl https://<STORAGE ACCOUNT>.blob.core.windows.net/<CONTAINER NAME>/traningfile.txt -H "x-ms-version: 2017-11-09" -H "Authorization: Bearer <ACCESS TOKEN>"
```

# Cleanup Demo
```
terraform destroy
```
