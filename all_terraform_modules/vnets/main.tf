resource "azurerm_virtual_network" "virt_network" {
  name                = "${var.base_name}_VNET"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}