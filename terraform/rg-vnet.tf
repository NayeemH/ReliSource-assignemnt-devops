provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "relisource" {
  name     = "relisource"
  location = "Central India"
}

resource "azurerm_virtual_network" "mgmt_vnet" {
  name                = "mgmt-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.relisource.location
  resource_group_name = azurerm_resource_group.relisource.name
}

resource "azurerm_virtual_network" "app_vnet" {
  name                = "app-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.relisource.location
  resource_group_name = azurerm_resource_group.relisource.name
}

resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "app-gateway-subnet"
  resource_group_name  = azurerm_resource_group.relisource.name
  virtual_network_name = azurerm_virtual_network.mgmt_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "app_private_endpoint_subnet" {
  name                 = "app-private-endpoint-subnet"
  resource_group_name  = azurerm_resource_group.relisource.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "app_firewall_subnet" {
  name                 = "app-firewall-subnet"
  resource_group_name  = azurerm_resource_group.relisource.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_subnet" "app_mysql_subnet" {
  name                 = "app-mysql-subnet"
  resource_group_name  = azurerm_resource_group.relisource.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = ["10.1.3.0/24"]
}

resource "azurerm_virtual_network_peering" "mgmt_to_app" {
  name                      = "mgmt-to-app"
  resource_group_name       = azurerm_resource_group.relisource.name
  virtual_network_name      = azurerm_virtual_network.mgmt_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.app_vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "app_to_mgmt" {
  name                      = "app-to-mgmt"
  resource_group_name       = azurerm_resource_group.relisource.name
  virtual_network_name      = azurerm_virtual_network.app_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.mgmt_vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  allow_virtual_network_access = true
}
