output "mysql_fqdn" {
  value = azurerm_mysql_server.demo.fqdn
}

output "demo_instance_ip" {
  description = "The actual ip address allocated for the resource."
  value       = azurerm_network_interface.demo-instance.private_ip_address
}

output "demo_instance_public_ip" {
  description = "The actual ip address allocated for the resource."
  value       = azurerm_public_ip.demo-instance.ip_address
}