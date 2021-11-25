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
ssh demo@PUBLIC_IP_HERE -i mykey
```

# Add mongodb repository and install mongodb client

```
sudo apt update
sudo apt install mongodb-clients
```

# Connect to mongodb database
*Check Azure portal for connect string

```
mongo URL:PORT -u USERNAME -p PASSWORDHERE --ssl --sslAllowInvalidCertificates
```

# Cleanup Demo
```
terraform destroy
```
