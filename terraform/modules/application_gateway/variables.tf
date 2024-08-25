variable "rg_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location of the application gateway."
}

variable "vnet_name" {
  description = "The name of the virtual network where the application gateway will be deployed."
}

variable "subnet_name" {
  description = "The name of the subnet for the application gateway."
}

variable "public_ip_name" {
  description = "The name of the public IP address for the application gateway."
}
