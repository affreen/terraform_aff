variable "base_name" {
  type        = string
  description = "Base name for the resource group"

}

variable "location" {
  type        = string
  description = "Location of the deployment"

}
variable "network_security_grp_name" {
  type        = string
  description = "Network security group name"

}
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