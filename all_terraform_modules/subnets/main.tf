resource "azurerm_subnet" "subnet_in_azure" {

  name = var.base_name
  #name                 = "${var.base_name}_SUBNET"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  #address_prefixes     = var.subnet_addr_prfx
  address_prefixes = var.subnet_addr_prfx

}
resource "azurerm_subnet_network_security_group_association" "test_association" {
  subnet_id                 = azurerm_subnet.subnet_in_azure.id
  network_security_group_id = var.network_security_group_id
}