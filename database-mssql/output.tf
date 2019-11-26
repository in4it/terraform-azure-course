output "mssql_fqdn" {
  value = azurerm_sql_server.demo.fully_qualified_domain_name
}

output "demo_instance_ip" {
  description = "The actual ip address allocated for the resource."
  value       = azurerm_network_interface.demo-instance.private_ip_address
}

output "demo_instance_public_ip" {
  description = "The actual ip address allocated for the resource."
  value       = azurerm_public_ip.demo-instance.ip_address
}

#output "mssql_failover_fqdn" {
#  description = "The actual ip address allocated for the resource."
#  value       = "${azurerm_sql_failover_group.failover.name}.database.windows.net"
#}
