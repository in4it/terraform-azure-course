output "connection_string" {
  value = azurerm_cosmosdb_account.db.connection_strings
}