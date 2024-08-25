resource "azurerm_firewall" "app_firewall" {
  name                = "app-firewall"
  location            = azurerm_resource_group.relisource.location
  resource_group_name = azurerm_resource_group.relisource.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.app_firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.app_firewall_public_ip.id
  }

  threat_intel_mode = "Alert"
}

resource "azurerm_firewall_network_rule_collection" "app_firewall_network_rule" {
  name                = "app-firewall-rule-collection"
  resource_group_name = azurerm_resource_group.relisource.name
  azure_firewall_name = azurerm_firewall.app_firewall.name
  priority            = 100
  action              = "Allow"

  rule {
    name                   = "allow-from-app-gateway"
    source_addresses       = [azurerm_public_ip.app_gateway_public_ip.ip_address]
    destination_addresses  = ["*"]
    destination_ports      = ["80", "443"]
    protocols              = ["TCP"]
  }
}
