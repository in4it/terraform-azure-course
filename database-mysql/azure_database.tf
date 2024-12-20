resource "azurerm_mysql_flexible_server" "demo" {
  name                = "mysql-training"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name

  sku_name = "B_Standard_B1s"

  administrator_login    = "mysqladmin"
  #administrator_password = "SETSECUREPASS"
}

resource "azurerm_mysql_flexible_database" "demo" {
  name                = "demodb"
  resource_group_name = azurerm_resource_group.demo.name
  server_name         = azurerm_mysql_flexible_server.demo.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "demo-allow-demo-instance" {
  name                = "mysql-demo-instance"
  resource_group_name = azurerm_resource_group.demo.name
  server_name         = azurerm_mysql_flexible_server.demo.name
  start_ip_address    = azurerm_network_interface.demo-instance.private_ip_address
  end_ip_address      = azurerm_network_interface.demo-instance.private_ip_address
}
