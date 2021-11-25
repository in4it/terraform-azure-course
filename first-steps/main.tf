provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "demo" {
  name     = "first-steps-demo"
  location = var.location
}
