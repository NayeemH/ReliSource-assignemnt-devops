resource "azurerm_virtual_network_peering" "mgmt_to_app" {
  name                      = "mgmt-to-app"
  resource_group_name       = var.rg_name
  virtual_network_name      = var.mgmt_vnet_name
  remote_virtual_network_id = var.app_vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "app_to_mgmt" {
  name                      = "app-to-mgmt"
  resource_group_name       = var.rg_name
  virtual_network_name      = var.app_vnet_name
  remote_virtual_network_id = var.mgmt_vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  allow_virtual_network_access = true
}
