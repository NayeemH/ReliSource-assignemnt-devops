variable "resource_group_name" {}
variable "location" {}

resource "azurerm_virtual_network" "management_vnet" {
  name                = "management-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "firewall_subnet" {
  name                 = "firewall-subnet"
  resource_group_name  = azurerm_virtual_network.management_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.management_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
