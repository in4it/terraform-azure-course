resource "random_string" "random-name" {
  length  = 10
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_resource_group" "demo" {
  name     = "application-gateway-demo-${random_string.random-name.result}"
  location = var.location
}
