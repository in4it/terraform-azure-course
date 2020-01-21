resource "random_string" "random-name" {
  length  = 8
  upper   = false
  lower   = false
  number  = true
  special = false
}

resource "azurerm_container_registry" "demo-app" {
  name                     = "demoapp${random_string.random-name.result}"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  sku                      = "Standard"
  admin_enabled            = false
}
