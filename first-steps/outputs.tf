output "vm_public_ip" {
  description = "The public IP address associated with the instance"
  value       = azurerm_public_ip.demo-instance.ip_address
}
