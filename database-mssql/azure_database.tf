resource "random_string" "random-name" {
  length  = 5
  upper   = false
  lower   = true
  number  = true
  special = false
}

resource "azurerm_sql_server" "demo" {
  name                         = "sqlserver-${random_string.random-name.result}"
  resource_group_name          = azurerm_resource_group.demo.name
  location                     = azurerm_resource_group.demo.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
#  administrator_login_password = "GOODPASSWORDHERE"
}

#resource "azurerm_sql_server" "demo-secondary" {
#  name                         = "sqlserver-s${random_string.random-name.result}"
#  resource_group_name          = azurerm_resource_group.demo.name
#  location                     = var.failover_location
#  version                      = "12.0"
#  administrator_login          = "sqladmin"
#  administrator_login_password = "SETSECUREPASS"
#}
#
#resource "azurerm_sql_failover_group" "failover" {
#  name                = "sqlserver-failover-group-${random_string.random-name.result}"
#  resource_group_name = azurerm_resource_group.demo.name
#  server_name         = azurerm_sql_server.demo.name
#  databases           = [azurerm_sql_database.training.id]
#
#  partner_servers {
#    id = azurerm_sql_server.demo-secondary.id
#  }
#
#  read_write_endpoint_failover_policy {
#    mode          = "Automatic"
#    grace_minutes = 60
#  }
#}

resource "azurerm_sql_database" "training" {
  name                             = "demodb"
  resource_group_name              = azurerm_resource_group.demo.name
  location                         = azurerm_resource_group.demo.location
  server_name                      = azurerm_sql_server.demo.name
  edition                          = "Standard"
  requested_service_objective_name = "S1"
}

resource "azurerm_sql_virtual_network_rule" "demo-database-subnet-vnet-rule" {
  name                = "mssql-vnet-rule"
  resource_group_name = azurerm_resource_group.demo.name
  server_name         = azurerm_sql_server.demo.name
  subnet_id           = azurerm_subnet.demo-database-1.id
}

resource "azurerm_sql_virtual_network_rule" "demo-subnet-vnet-rule" {
  name                = "mssql-demo-subnet-vnet-rule"
  resource_group_name = azurerm_resource_group.demo.name
  server_name         = azurerm_sql_server.demo.name
  subnet_id           = azurerm_subnet.demo-internal-1.id
}

resource "azurerm_sql_firewall_rule" "demo-allow-demo-instance" {
  name                = "mssql-demo-instance"
  resource_group_name = azurerm_resource_group.demo.name
  server_name         = azurerm_sql_server.demo.name
  start_ip_address    = azurerm_network_interface.demo-instance.private_ip_address
  end_ip_address      = azurerm_network_interface.demo-instance.private_ip_address
}
