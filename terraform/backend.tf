terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "tfstatebackendnh"
    container_name       = "tfstatereli"
    key                  = "terraform.tfstate"
  }
}
