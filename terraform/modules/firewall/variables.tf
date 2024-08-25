variable "rg_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location of the Firewall."
}

variable "vnet_name" {
  description = "The name of the virtual network for the Firewall."
}

variable "subnet_name" {
  description = "The name of the subnet for the Firewall."
}

variable "public_ip_name" {
  description = "The name of the public IP for the Firewall."
}

variable "allowed_ip" {
  description = "The IP address allowed to access resources behind the Firewall."
}
