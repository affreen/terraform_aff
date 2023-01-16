variable "base_name" {
  type = string
  description = "Base name for VNET"
}

variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
}

variable "virtual_network_name" {
  type = string
  description = "VNET name"
}

variable "subnet_addr_prfx" {
  type = list(string)
  description = "Address prefix of the subnets inside the VNETs"
}
variable "network_security_group_id" {
  type = string
  description = "Address prefix of the subnets inside the VNETs"
}
