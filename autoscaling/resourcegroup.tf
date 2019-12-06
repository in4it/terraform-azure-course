resource "azurerm_resource_group" "demo" {
  name     = "autoscaling-demo"
  location = var.location
}
