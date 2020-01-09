output "display_name" {
  value = "${azuread_service_principal.training-sp.display_name}"
}

output "client_id" {
  value = "${azuread_application.training-app.application_id}"
}

output "client_secret" {
  value     = "${azuread_service_principal_password.sp-password.value}"
  sensitive = true
}

output "object_id" {
  value = "${azuread_service_principal.training-sp.id}"
}