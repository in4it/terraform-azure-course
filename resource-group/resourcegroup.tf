resource "azurerm_resource_group" "demo" {
  name     = "resource-group-demo"
  location = var.location
  tags = {
      env = "resource-group-demo"
  }
}
