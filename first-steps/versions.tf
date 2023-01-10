terraform {
  required_version = ">= 1.3.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.38.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
  }
}
