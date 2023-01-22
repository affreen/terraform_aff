variable "base_name" {
  type        = string
  description = "Base name for the resource group"

}

variable "location" {
  type        = string
  description = "Location of the deployment"

}

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
  type        = map(any)
  description = "List of subnets"
  default = {
    subnet_01 = {
      name = "subnet_01",
      ip   = "10.0.1.0/24"
    },
    subnet_02 = {
      name = "subnet_02",
      ip   = "10.0.2.0/24"
    },
    subnet_03 = {
      name = "subnet_03",
      ip   = "10.0.3.0/24"
    }
  }
}

variable "vnet_list" {
  type        = map(any)
  description = "List of subnets"
  default = {
    vnet_01 = {
      name      = "vnet_01_spoke",
      ip        = "10.0.0.0/16",
      subnet_ip = "10.0.1.0/24"

    },
    vnet_02 = {
      name      = "vnet_02_spoke",
      ip        = "192.168.0.0/16",
      subnet_ip = "192.168.1.0/24"
    },
    vnet_03 = {
      name      = "vnet_hub",
      ip        = "172.16.0.0/16",
      subnet_ip = "172.16.1.0/24"
    }

  }
}