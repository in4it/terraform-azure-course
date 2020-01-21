provider "azurerm" {
  version = "=1.41.0"
}

# Create a resource group
resource "azurerm_resource_group" "demo" {
  name     = "kubernetes-demo"
  location = var.location
}
