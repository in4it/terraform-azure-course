# Setup MSSQL Database

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

# Add microsoft repository and install mssql tools

```
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update 
sudo apt-get install -y mssql-tools unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
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