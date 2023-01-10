variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "demo"
}

variable "private_ssh_key" {
  type        = string
  description = "The path to the public SSH key to associate with the VM"
  default     = "mykey"
}

variable "vm_admin_user" {
  type        = string
  description = "The name of the administrator user in the VM"
  default     = "adminuser"
}
