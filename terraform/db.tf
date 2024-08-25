 resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                = "mysql-server"
  location            = azurerm_resource_group.relisource.location
  resource_group_name = azurerm_resource_group.relisource.name
  administrator_login = "adminuser"
  administrator_password = "Password123!"
  sku_name            = "Standard_B1ms"
  storage_mb          = 5120
  version             = "8.0"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  high_availability {
    mode = "ZoneRedundant"
  }

  network {
    delegated_subnet_id = azurerm_subnet.app_mysql_subnet.id
    private_dns_zone_id = azurerm_private_dns_zone.privatelink_mysql_database_azure_com.id
  }

  tags = {
    environment = "production"
  }
}

resource "azurerm_private_dns_zone" "privatelink_mysql_database_azure_com" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.relisource.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql_vnet_link" {
  name                  = "mysql-vnet-link"
  resource_group_name   = azurerm_resource_group.relisource.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_mysql_database_azure_com.name
  virtual_network_id    = azurerm_virtual_network.app_vnet.id
}

resource "azurerm_private_dns_a_record" "mysql_server_record" {
  name                = azurerm_mysql_flexible_server.mysql_server.name
  zone_name           = azurerm_private_dns_zone.privatelink_mysql_database_azure_com.name
  resource_group_name = azurerm_resource_group.relisource.name
  ttl                 = 300
  records             = [azurerm_mysql_flexible_server.mysql_server.private_ip_address]
}
