# demo instance
resource "azurerm_virtual_machine" "demo-instance" {
  name                  = "${var.prefix}-vm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.demo.name
  network_interface_ids = [azurerm_network_interface.demo-instance.id]
  vm_size               = "Standard_A1_v2"

  # this is a demo instance, so we can delete all data on termination
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "demo-instance"
    admin_username = "demo"
    #admin_password = "..."
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("mykey.pub")
      path     = "/home/demo/.ssh/authorized_keys"
    }
  }

  tags = {for k, v in merge({ name = "instance1" }, var.project_tags): k => lower(v)}
}

resource "azurerm_network_interface" "demo-instance" {
  name                      = "${var.prefix}-instance1"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.demo.name
  network_security_group_id = azurerm_network_security_group.allow-ssh.id

  dynamic ip_configuration {
    for_each = var.ip-config
    content {
      name                          = lookup(ip_configuration.value, "name")
      subnet_id                     = azurerm_subnet.demo-internal-1.id
      private_ip_address_allocation = lookup(ip_configuration.value, "allocation")
      public_ip_address_id          = azurerm_public_ip.demo-instance[ip_configuration.key].id
      primary                       = lookup(ip_configuration.value, "primary")
    }
  }
}

resource "azurerm_public_ip" "demo-instance" {
    count                        = length(var.ip-config)
    name                         = "instance1-public-ip-${count.index}"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.demo.name
    allocation_method            = "Static"
}
