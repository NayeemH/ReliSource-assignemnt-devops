variable "resource_group_name" {}
variable "location" {}

resource "azurerm_virtual_network" "application_vnet" {
  name                = "application-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_virtual_network.application_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.application_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

output "app_subnet_id" {
  value = azurerm_subnet.app_subnet.id
}
