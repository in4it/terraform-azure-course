resource "azurerm_application_gateway" "app-gateway" {
  name                = "appgateway"
  resource_group_name = azurerm_resource_group.demo.name
  location            = var.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = azurerm_subnet.demo-subnet-1.id
  }

  frontend_port {
    name = "webAppPport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "webAppPport"
    public_ip_address_id = azurerm_public_ip.demo.id
  }

  backend_address_pool {
    name = "BackEndAddressPool"
  }

  backend_http_settings {
    name                  = "httpSetting"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "webAppPport"
    frontend_port_name             = "webAppPport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "httpRoutingRule"
    rule_type                  = "Basic"
    http_listener_name         = "httpListener"
    backend_address_pool_name  = "BackEndAddressPool"
    backend_http_settings_name = "httpSetting"
  }
}

resource "azurerm_public_ip" "demo" {
  name                = "demo-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name
  allocation_method   = "Dynamic"
  domain_name_label   = azurerm_resource_group.demo.name
}