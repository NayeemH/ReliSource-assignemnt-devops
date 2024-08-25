variable "resource_group_name" {}
variable "location" {}
resource "random_id" "server_id" {
  byte_length = 4
}


resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                = "mysql-server-${random_id.server_id.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name            = "GP_Standard_D2ds_v4"
  version             = "5.7"
  administrator_login = "mysqladmin"
  administrator_password = "Password123!"
  zone = "3"
}

resource "azurerm_mysql_flexible_database" "mysql_database" {
  name                = "mydatabase"
  resource_group_name = azurerm_mysql_flexible_server.mysql_server.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}
