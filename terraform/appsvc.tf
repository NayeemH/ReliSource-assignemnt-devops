resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "app-service-plan"
  location            = azurerm_resource_group.relisource.location
  resource_group_name = azurerm_resource_group.relisource.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "app-service"
  location            = azurerm_resource_group.relisource.location
  resource_group_name = azurerm_resource_group.relisource.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  site_config {
    always_on = true
  }
}

resource "azurerm_private_endpoint" "app_service_private_endpoint" {
  name                = "app-service-private-endpoint"
  location            = azurerm_resource_group.relisource.location
  resource_group_name = azurerm_resource_group.relisource.name
  subnet_id           = azurerm_subnet.app_private_endpoint_subnet.id

  private_service_connection {
    name                           = "app-service-private-connection"
    private_connection_resource_id = azurerm_app_service.app_service.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_zone" "privatelink_azurewebsites_net" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.relisource.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "vnet-link"
  resource_group_name   = azurerm_resource_group.relisource.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_azurewebsites_net.name
  virtual_network_id    = azurerm_virtual_network.app_vnet.id
}

resource "azurerm_private_dns_a_record" "app_service_record" {
  name                = azurerm_app_service.app_service.name
  zone_name           = azurerm_private_dns_zone.privatelink_azurewebsites_net.name
  resource_group_name = azurerm_resource_group.relisource.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.app_service_private_endpoint.private_ip_address]
}
