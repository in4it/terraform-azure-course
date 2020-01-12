resource "random_string" "random-name" {
  length  = 5
  upper   = false
  lower   = true
  number  = true
  special = false
}

# Example conditionally omitted argument
variable "override_tier" {
  type    = string
  default = null
}

resource "azurerm_storage_account" "trainingsa" {
  name                     = "trainingsa${random_string.random-name.result}"
  location                 = azurerm_resource_group.demo.location
  resource_group_name      = azurerm_resource_group.demo.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # Example conditionally omitted argument
  access_tier              = var.override_tier          
}

resource "azurerm_storage_container" "trainingco" {
  name                  = "trainingco${random_string.random-name.result}"
  storage_account_name  = azurerm_storage_account.trainingsa.name
  container_access_type = "private"
}


variable "filename" {
  type    = string
  default = ""
}


resource "azurerm_storage_blob" "training-file" {
  name                   = var.filename != "" ? var.filename : "traningfile.txt"
  storage_account_name   = azurerm_storage_account.trainingsa.name
  storage_container_name = azurerm_storage_container.trainingco.name
  type                   = "Block"
  source                 = var.filename != "" ? var.filename : "traningfile.txt"
}

