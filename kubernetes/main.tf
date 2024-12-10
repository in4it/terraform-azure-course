terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.53.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.6.2"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
  }
}

# Create a resource group
resource "azurerm_resource_group" "demo" {
  name     = "kubernetes-demo"
  location = var.location
}
