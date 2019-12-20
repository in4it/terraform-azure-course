output "connection_strings" {
  value = azurerm_cosmosdb_account.db.connection_strings
}

output "demo_instance_public_ip" {
  description = "The actual ip address allocated for the resource."
  value       = azurerm_public_ip.demo-instance.ip_address
}
