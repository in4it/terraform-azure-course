# demo instance
resource "azurerm_linux_virtual_machine" "demo-instance" {
  name                  = "${var.prefix}-vm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.demo.name
  network_interface_ids = [azurerm_network_interface.demo-instance.id]
  size                  = "Standard_B1ls"
  admin_username        = "adminuser"

  // az vm image list --architecture x64 --location eastus --publisher Canonical --all --sku 22_04-lts-gen2
  source_image_reference {
    publisher = "Canonical"
    sku       = "22_04-lts-gen2"
    offer     = "0001-com-ubuntu-server-jammy"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    public_key = file("mykey.pub")
    username   = "adminuser"
  }
}

resource "azurerm_network_interface" "demo-instance" {
  name                = "${var.prefix}-instance1"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name

  ip_configuration {
    name                          = "instance1"
    subnet_id                     = azurerm_subnet.demo-internal-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.demo-instance.id
  }
}

resource "azurerm_network_interface_security_group_association" "allow-ssh" {
  network_interface_id      = azurerm_network_interface.demo-instance.id
  network_security_group_id = azurerm_network_security_group.allow-ssh.id
}

resource "azurerm_public_ip" "demo-instance" {
  name                = "instance1-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name
  allocation_method   = "Dynamic"
}
