provider "azurerm" {
  features {}
}

resource "random_id" "app_name_suffix" {
  byte_length = 4
}

module "resource_group" {
  source = "./modules/resource_group"
  rg_name = "relisource"
  location = "Central India"
}

module "mgmt_vnet" {
  source     = "./modules/virtual_network"
  vnet_name  = "mgmt-vnet"
  rg_name    = module.resource_group.rg_name
  location   = module.resource_group.location
  address_space = ["10.0.0.0/16"]
}

module "app_vnet" {
  source     = "./modules/virtual_network"
  vnet_name  = "app-vnet"
  rg_name    = module.resource_group.rg_name
  location   = module.resource_group.location
  address_space = ["10.1.0.0/16"]
}

module "vnet_peering" {
  source              = "./modules/vnet_peering"
  rg_name             = module.resource_group.rg_name
  mgmt_vnet_name      = module.mgmt_vnet.vnet_name
  app_vnet_name       = module.app_vnet.vnet_name
  mgmt_vnet_id        = module.mgmt_vnet.vnet_id
  app_vnet_id         = module.app_vnet.vnet_id
}

module "application_gateway" {
  source             = "./modules/application_gateway"
  rg_name            = module.resource_group.rg_name
  vnet_name          = module.mgmt_vnet.vnet_name
  location           = module.resource_group.location
  subnet_name        = "app-gateway-subnet"
  public_ip_name     = "app-gateway-pip"
}

module "app_service" {
  source              = "./modules/app_service"
  rg_name             = module.resource_group.rg_name
  location            = module.resource_group.location
  vnet_name           = module.app_vnet.vnet_name
  subnet_name         = "app-service-subnet"
  app_service_plan_name = "app_service_plan_name-${random_id.app_name_suffix.hex}"
  app_service_name    = "web-app-${random_id.app_name_suffix.hex}"
  private_endpoint_name = "app-private-endpoint"
}

module "firewall" {
  source              = "./modules/firewall"
  rg_name             = module.resource_group.rg_name
  location            = module.resource_group.location
  vnet_name           = module.app_vnet.vnet_name
  subnet_name         = "AzureFirewallSubnet"
  public_ip_name      = "app-fw-pip"
  allowed_ip          = module.application_gateway.public_ip_address
}

module "mysql" {
  source            = "./modules/mysql"
  rg_name           = module.resource_group.rg_name
  location          = module.resource_group.location
  vnet_name         = module.app_vnet.vnet_name
  subnet_name       = "mysql-subnet"
  db_name           = "reli-${random_id.app_name_suffix.hex}"
}
