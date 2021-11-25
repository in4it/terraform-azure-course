output "connection_strings" {
  value     = nonsensitive(azurerm_cosmosdb_account.db.connection_strings)
}

output "demo_instance_public_ip" {
  description = "The actual ip address allocated for the resource."
  value       = data.azurerm_public_ip.public_ip.ip_address
}
