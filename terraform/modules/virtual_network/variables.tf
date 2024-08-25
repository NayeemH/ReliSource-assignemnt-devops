variable "vnet_name" {
  description = "The name of the virtual network."
}

variable "rg_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location of the virtual network."
}

variable "address_space" {
  description = "The address space of the virtual network."
  type        = list(string)
}
