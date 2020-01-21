resource "random_password" "aks-demo-sp-password" {
  length  = 32
  special = true
}

resource "azuread_application" "aks-demo" {
  name                       = "aks-demo"
  available_to_other_tenants = false
}

resource "azuread_service_principal" "aks-demo" {
  application_id = azuread_application.aks-demo.application_id
}

resource "azuread_service_principal_password" "aks-demo" {
  service_principal_id = azuread_service_principal.aks-demo.id
  value                = random_password.aks-demo-sp-password.result
  end_date_relative    = "17520h" #2y
}

