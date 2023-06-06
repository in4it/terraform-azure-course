resource "azurerm_resource_group" "demo" {
  name     = "application-gateway-demo"
  location = var.location
}
