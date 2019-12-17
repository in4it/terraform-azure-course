output "mssql_fqdn" {
  description = "The FQDN of the sql server."
  value = azurerm_sql_server.demo.fully_qualified_domain_name
}

output "demo_instance_ip" {
  description = "The actual ip address allocated for the resource."
  value       = azurerm_network_interface.demo-instance.private_ip_address
}

output "demo_instance_public_ip" {
  description = "The actual public ip address allocated for the resource."
  value       = azurerm_public_ip.demo-instance.ip_address
}


output "mssql_connect_string" {
  description = "The connectstring to connect to the database"
  value       =  "Server=tcp:${azurerm_sql_server.demo.fully_qualified_domain_name} Database=${azurerm_sql_database.training.name};User ID=${azurerm_sql_server.demo.administrator_login};Password=${azurerm_sql_server.demo.administrator_login_password};Trusted_Connection=False;Encrypt=True;"
}

#output "mssql_failover_fqdn" {
#  description = "The FQDN of the failover group."
#  value       = "${azurerm_sql_failover_group.failover.name}.database.windows.net"
#}

