resource "azurerm_subnet" "firewall_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_public_ip" "firewall_pip" {
  name                = var.public_ip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "network_firewall" {
  name                = "network-firewall"
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  ip_configuration {
    name      = "configuration"
    subnet_id = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}

resource "azurerm_firewall_network_rule_collection" "rule_collection" {
  name                = "AllowAppGatewayTraffic"
  resource_group_name = var.rg_name
  azure_firewall_name = azurerm_firewall.network_firewall.name
  priority            = 100
  action              = "Allow"

  rule {
    name                  = "AllowAppGateway"
    source_addresses      = [var.allowed_ip]
    destination_ports     = ["80"]
    destination_addresses = ["*"]
    protocols             = ["TCP"]
  }
}
