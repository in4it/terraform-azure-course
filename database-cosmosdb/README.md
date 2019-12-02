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

# Add mongodb repository and install mssql tools

```
wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org-shell
```

# Connect to mssql database
*The output of terraform shows the dns of the MySQL*

```
sqlcmd -S DNSNAMEHERE -U sqladmin -P 'REPLACEWITHPASSWORD' -q "SELECT name FROM master.sys.databases"
```

# Cleanup Demo
```
terraform destroy
```

# Connect to mssql database via failovergroup
*The output of terraform shows the dns of the MySQL*

```
sqlcmd -S DNSNAMEHERE -U sqladmin -P 'REPLACEWITHPASSWORD' -q "SELECT name FROM master.sys.databases"
```