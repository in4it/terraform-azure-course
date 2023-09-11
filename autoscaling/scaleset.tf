resource "azurerm_linux_virtual_machine_scale_set" "demo" {
  name                = "mytestscaleset-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name

  # automatic rolling upgrade
  automatic_os_upgrade_policy {
    enable_automatic_os_upgrade = false
    disable_automatic_rollback  = false
  }

  rolling_upgrade_policy {
    max_batch_instance_percent              = 20
    max_unhealthy_instance_percent          = 20
    max_unhealthy_upgraded_instance_percent = 5
    pause_time_between_batches              = "PT0S"
  }

  upgrade_mode = "Rolling"

  # required when using rolling upgrade policy
  health_probe_id = azurerm_lb_probe.demo.id

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

  admin_username       = "demo"
  computer_name_prefix = "demo"
  custom_data          = base64encode("#!/bin/bash\n\napt-get update && apt-get install -y nginx && systemctl enable nginx && systemctl start nginx")

  data_disk {
    lun                  = 0
    caching              = "ReadWrite"
    create_option        = "Empty"
    disk_size_gb         = 10
    storage_account_type = "Standard_LRS"
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
      name                                   = "IPConfiguration"
      primary                                = true
      subnet_id                              = azurerm_subnet.demo-subnet-1.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.lbnatpool.id]
    }
  }
}
