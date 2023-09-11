resource "azurerm_linux_virtual_machine_scale_set" "demo" {
  name                = "mytestscaleset-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name

  zones = var.zones

  instances = 2
  sku       = "Standard_B1s"

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username = "demo"

  extension {
    name                 = "InstallCustomScript"
    publisher            = "Microsoft.Azure.Extensions"
    type                 = "CustomScript"
    type_handler_version = "2.0"
    settings             = <<SETTINGS
        {
          "fileUris": ["https://raw.githubusercontent.com/in4it/terraform-azure-course/master/application-gateway/install_nginx.sh"],
          "commandToExecute": "./install_nginx.sh"
        }
      SETTINGS
  }

  admin_ssh_key {
    username   = "demo"
    public_key = file("mykey.pub")
  }

  network_interface {
    name                      = "networkprofile"
    primary                   = true
    network_security_group_id = azurerm_network_security_group.demo-instance.id

    ip_configuration {
      name                                         = "IPConfiguration"
      primary                                      = true
      subnet_id                                    = azurerm_subnet.demo-subnet-2.id
      application_gateway_backend_address_pool_ids = azurerm_application_gateway.app-gateway.backend_address_pool[*].id
    }
  }
}
