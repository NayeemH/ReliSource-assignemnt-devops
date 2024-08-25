resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = "app-gateway-public-ip"
  location            = azurerm_resource_group.relisource.location
  resource_group_name = azurerm_resource_group.relisource.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = "app-gateway"
  location            = azurerm_resource_group.relisource.location
  resource_group_name = azurerm_resource_group.relisource.name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "app-gateway-ip-config"
    subnet_id = azurerm_subnet.app_gateway_subnet.id
  }
  frontend_ip_configuration {
    name                 = "app-gateway-frontend-ip"
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }
  frontend_port {
    name = "frontend-port"
    port = 80
  }
  backend_address_pool {
    name = "backend-pool"
  }
  http_settings {
    name                  = "http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }
  request_routing_rule {
    name                       = "routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "app-gateway-listener"
    backend_address_pool_id    = azurerm_application_gateway_backend_address_pool.app_gateway_backend.id
    backend_http_settings_id   = azurerm_application_gateway_http_settings.app_gateway_http_settings.id
  }
  tags = {
    environment = "production"
  }
}
