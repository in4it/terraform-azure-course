resource "azurerm_virtual_network" "demo" {
  name                = "${var.prefix}-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "demo-internal-1" {
  name                 = "${var.prefix}-internal-1"
  resource_group_name  = azurerm_resource_group.demo.name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "allow-ssh" {
  name                = "${var.prefix}-allow-ssh"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name

  /*
   Error: deleting Network Security Group "demo-allow-ssh" (Resource Group
   "first-steps-demo"): network.SecurityGroupsClient#Delete: Failure sending
   request: StatusCode=400 -- Original Error:
   Code="NetworkSecurityGroupOldReferencesNotCleanedUp" Message="Network
   security group demo-allow-ssh cannot be deleted because old references for
   the following Nics:
  */
  depends_on = [
    azurerm_network_interface.demo-instance
  ]

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${data.http.myip.response_body}/32"
    destination_address_prefix = "*"
  }
}
