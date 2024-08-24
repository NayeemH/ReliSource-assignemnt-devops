variable "resource_group_name" {}
variable "location" {}
variable "app_subnet_id" {}

resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = "app-gateway-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = "app-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.app_subnet_id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontendIpConfig"
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  backend_address_pool {
    name = "backendPool"
  }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "frontendIpConfig"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "httpListener"
    backend_address_pool_name  = "backendPool"
    backend_http_settings_name = "httpSettings"
    priority                   = 1
  }

  backend_http_settings {
    name                  = "httpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
  }
}
