resource "azuread_application" "aks-demo" {
  display_name = "aks-demo"
}

resource "azuread_service_principal" "aks-demo" {
  client_id = azuread_application.aks-demo.client_id
}

resource "azuread_service_principal_password" "aks-demo" {
  # value is now autogenerated
  # value = random_password.aks-demo-sp-password.result
  service_principal_id = azuread_service_principal.aks-demo.id
}

output "service_principal_password" {
  value     = azuread_service_principal_password.aks-demo.value # the value of azuread_service_principal_password.aks-demo is now autogenerated and outputted here
  sensitive = true
}
