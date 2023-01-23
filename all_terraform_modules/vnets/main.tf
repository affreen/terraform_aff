resource "azurerm_virtual_network" "virt_network" {
  name                = "${var.base_name}_VNET"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

module "subnets" {
  source = "../subnets"
  base_name ="mysubnet"
  resource_group_name = azurerm_virtual_network.virt_network.resource_group_name
  virtual_network_name =  azurerm_virtual_network.virt_network.name
  subnet_addr_prfx=var.subnet_addr_prfx
  network_security_group_id = var.network_security_group_id
}

