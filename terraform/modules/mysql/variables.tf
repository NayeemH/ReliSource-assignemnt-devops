variable "rg_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location of the MySQL database."
}

variable "vnet_name" {
  description = "The name of the virtual network for the MySQL database."
}

variable "subnet_name" {
  description = "The name of the subnet for the MySQL database."
}

variable "db_name" {
  description = "The name of the MySQL database."
}
