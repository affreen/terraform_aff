output "vnet_out" {
    value = azurerm_virtual_network.virt_network.name

}
output "address_space_out" {
    value = azurerm_virtual_network.virt_network.address_space

}