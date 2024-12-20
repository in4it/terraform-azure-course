# Setup MySQL Database

# Important Note
If the MySQL Server creation is stuck in a "creating" state for 1 hour, that specific type of server can't be created in that region. Try another region or SKU. 

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

# Install MySQL client & Connect to MySQL from virtual machine
The output of terraform shows the dns of the MySQL

```
sudo apt-get update
sudo apt-get install mysql-client-8.0
mysql -h DNSNAMEHERE -u mysqladmin@mysql-training -p
```

# Cleanup Demo
```
terraform destroy
```
