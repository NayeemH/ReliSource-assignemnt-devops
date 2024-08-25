resource "azurerm_subnet" "mysql_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.1.6.0/24"]
    delegation {
    name = "mysqlDelegation"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                = var.db_name
  location            = var.location
  resource_group_name = var.rg_name
  version             = "5.7"
  storage {
    size_gb = 1024
  }
  sku_name            = "GP_Standard_D2ds_v4"
  administrator_login = "mysqladmin"
  administrator_password = "AdminPassword123!"

  delegated_subnet_id = azurerm_subnet.mysql_subnet.id
}
