variable "rg_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location of the App Service."
}

variable "vnet_name" {
  description = "The name of the virtual network for the App Service."
}

variable "subnet_name" {
  description = "The name of the subnet for the App Service."
}

variable "app_service_name" {
  description = "The name of the App Service."
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan."
}

variable "private_endpoint_name" {
  description = "The name of the private endpoint for the App Service."
}
