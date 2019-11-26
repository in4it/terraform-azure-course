# Setup MySQL Database

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

# Connect to MySQL from virtual machine
The output of terraform shows the dns of the MySQL

```
mysql -h mysql-training.mysql.database.azure.com -u mysqladmin@mysql-training -p
```

# Cleanup Demo
```
terraform destroy
```