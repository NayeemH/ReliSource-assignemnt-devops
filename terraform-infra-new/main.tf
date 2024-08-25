provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "relisource" {
  name     = "relisource"
  location = "Central India"
}

module "management_vnet" {
  source              = "./management_vnet"
  resource_group_name = azurerm_resource_group.relisource.name
  location            = azurerm_resource_group.relisource.location
}

module "application_vnet" {
  source              = "./application_vnet"
  resource_group_name = azurerm_resource_group.relisource.name
  location            = azurerm_resource_group.relisource.location
}

module "app_gateway" {
  source              = "./app_gateway"
  resource_group_name = azurerm_resource_group.relisource.name
  location            = azurerm_resource_group.relisource.location
  app_subnet_id       = module.application_vnet.app_subnet_id
}

module "web_app" {
  source              = "./web_app"
  resource_group_name = azurerm_resource_group.relisource.name
  location            = azurerm_resource_group.relisource.location
  web_app_subnet_id   = module.application_vnet.web_app_subnet_id
}

module "mysql_db" {
  source              = "./mysql_db"
  resource_group_name = azurerm_resource_group.relisource.name
  location            = azurerm_resource_group.relisource.location
}
