resource "azurerm_resource_group" "res_grp" {
  name     = "${var.base_name}_RG"
  location = var.location
}