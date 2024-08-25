variable "resource_group_name" {}
variable "location" {}
variable "web_app_subnet_id" {}
resource "random_id" "app_name_suffix" {
  byte_length = 4
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "app-service-plan-${random_id.app_name_suffix.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_app_service" "web_app" {
  name                = "web-app-${random_id.app_name_suffix.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_service_plan.app_service_plan.id

  site_config {
    app_command_line = "npm start"
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "18.17.0"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  app_service_id = azurerm_app_service.web_app.id
  subnet_id      = var.web_app_subnet_id
}