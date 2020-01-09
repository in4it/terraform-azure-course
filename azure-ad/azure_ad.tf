data "azurerm_subscription" "main" {}

resource "random_string" "random-name" {
  length  = 5
  upper   = false
  lower   = true
  number  = true
  special = false
}

resource "azuread_application" "training-app" {
  name                       = "training-ad-${random_string.random-name.result}"
  available_to_other_tenants = false
}

resource "azuread_service_principal" "training-sp" {
  application_id = azuread_application.training-app.application_id
}

resource "random_password" "password" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "sp-password" {
  service_principal_id = azuread_service_principal.training-sp.id
  value                = random_password.password.result
  end_date_relative    = "17520h" #2y
}

resource "azurerm_role_assignment" "contributor" {
  scope                = data.azurerm_subscription.main.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.training-sp.id
}

