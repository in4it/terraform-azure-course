output "vm_public_ip" {
  description = "The public IP address associated with the instance"
  value       = azurerm_public_ip.demo-instance.ip_address
}

output "ssh_connect_command" {
  description = "The command line to connect to the VM with SSH"
  value       = "ssh -i ${var.private_ssh_key} ${azurerm_public_ip.demo-instance.ip_address} -l ${var.vm_admin_user}"
}
