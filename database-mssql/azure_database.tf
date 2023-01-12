resource "random_string" "random-name" {
  length  = 5
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_mssql_server" "demo" {
  name                         = "sqlserver-${random_string.random-name.result}"
  resource_group_name          = azurerm_resource_group.demo.name
  location                     = azurerm_resource_group.demo.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  #administrator_login_password = "GOODPASSWORDHERE"
}

#resource "azurerm_mssql_server" "demo-secondary" {
#  name                         = "sqlserver-s${random_string.random-name.result}"
#  resource_group_name          = azurerm_resource_group.demo.name
#  location                     = var.failover_location
#  version                      = "12.0"
#  administrator_login          = "sqladmin"
#  administrator_login_password = "SETSECUREPASS"
#}
#
#resource "azurerm_mssql_failover_group" "failover" {
#  name                = "sqlserver-failover-group-${random_string.random-name.result}"
#  resource_group_name = azurerm_resource_group.demo.name
#  server_id           = azurerm_mssql_server.demo.id
#  databases           = [azurerm_mssql_database.training.id]
#
#  partner_servers {
#    id = azurerm_mssql_server.demo-secondary.id
#  }
#
#  read_write_endpoint_failover_policy {
#    mode          = "Automatic"
#    grace_minutes = 60
#  }
#}

resource "azurerm_mssql_database" "training" {
  name                             = "demodb"
  server_id                        = azurerm_mssql_server.demo.id
  sku_name                         = "S1"
}

resource "azurerm_mssql_virtual_network_rule" "demo-database-subnet-vnet-rule" {
  name                = "mssql-vnet-rule"
  server_id           = azurerm_mssql_server.demo.id
  subnet_id           = azurerm_subnet.demo-database-1.id
}

resource "azurerm_mssql_virtual_network_rule" "demo-subnet-vnet-rule" {
  name                = "mssql-demo-subnet-vnet-rule"
  server_id           = azurerm_mssql_server.demo.id
  subnet_id           = azurerm_subnet.demo-internal-1.id
}

resource "azurerm_mssql_firewall_rule" "demo-allow-demo-instance" {
  name                = "mssql-demo-instance"
  server_id           = azurerm_mssql_server.demo.id
  start_ip_address    = azurerm_network_interface.demo-instance.private_ip_address
  end_ip_address      = azurerm_network_interface.demo-instance.private_ip_address
}
