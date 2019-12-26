output "demo_instance_public_ip" {
  description = "The actual ip address allocated for the resource."
  value       = azurerm_public_ip.demo-instance.ip_address
}

output "training_file_location" {
  description = "The url of the trainig file"
  value       = azurerm_storage_blob.training-file.url
}
