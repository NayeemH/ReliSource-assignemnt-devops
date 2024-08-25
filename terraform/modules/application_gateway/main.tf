resource "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = "app-gateway"
  location            = var.location
  resource_group_name = var.rg_name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "app-gateway-ipcfg"
    subnet_id = azurerm_subnet.app_gateway_subnet.id
  }
  frontend_ip_configuration {
    name                 = "app-gateway-frontend"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
  frontend_port {
    name = "frontend-port"
    port = 80
  }
  backend_address_pool {
    name = "backend-pool"
  }
  http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = "app-gateway-frontend"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }
  request_routing_rule {
    name                       = "routing-rule"
    http_listener_name         = "listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-settings"
    rule_type                  = "Basic"
    priority                   = 100
  }
  backend_http_settings {
    name                  = "http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
  }
}

output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}
