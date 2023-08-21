terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.70.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.41.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
  }
}

# Configure the Azure Active Directory Provider
provider "azuread" {
}
