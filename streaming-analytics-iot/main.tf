provider "azurerm" {
  version = "=1.35.0"
}

# Create a resource group
resource "azurerm_resource_group" "demo" {
  name     = "demo-stream-iot"
  location = var.location
}
