variable "base_name" {
  type = string
  description = "Base name for VNET"
}

variable "location" {
  type = string
  description = "Location of the deployment"
}

variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
}

variable "address_space" {
  type = list(string)
  description = "Address space of the VNET"

}