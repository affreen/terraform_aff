resource "azurerm_subnet" "subnet_in_azure" {
  name                 = "${var.base_name}_SUBNET"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_addr_prfx

}