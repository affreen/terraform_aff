variable "base_name" {
  type        = string
  description = "Base name for the resource group"

}

variable "location" {
  type        = string
  description = "Location of the deployment"

}
#variable "network_security_grp_name" {
#  type        = string
#  description = "Network security group name"
#
#}
#variable "all_networks" {
#    type = list
#    description = "Network address of the VNETs"
#    default = ["192.168.0.0/16", "10.0.0.0/16"]
#
#}
variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "NSG rules and its settings"
}

variable "all_networks" {
  type        = list(any)
  description = "Network address of the VNETs"
  default     = ["192.168.0.0/16", "10.0.0.0/16"]

}

variable "address_space" {
  type        = list(string)
  description = "Address space of the VNET"

}

#variable "subnet_addr_prfx" {
#  type        = list(string)
#  description = "Address space of the subnets inside VNETs"
#}

variable "subnet_list" {
  type = map(any)
  description = "List of subnets"
  default = {
    subnet_01 = {
             name = "subnet_01",
             ip= "10.0.1.0/24"
    },
    subnet_02 = {
             name = "subnet_02",
             ip= "10.0.2.0/24"
    },
    subnet_03 = {
             name = "subnet_03",
             ip= "10.0.3.0/24"
    }
  }
}
