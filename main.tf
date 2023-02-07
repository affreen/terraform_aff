terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.39.1"
    }
  }
}

provider "azurerm" {
  features {}
}

module "create_resource_group" {
  source    = "./all_terraform_modules/resource_group"
  base_name = var.base_name
  location  = var.location

}
module "create_nsg" {
  source              = "./all_terraform_modules/network_security_groups"
  base_name           = var.base_name
  location            = var.location
  resource_group_name = module.create_resource_group.resource_group_name_out
  #network_security_grp_name = var.network_security_grp_name
  nsg_rules = var.nsg_rules

}
module "create_vnet" {
  for_each            = var.vnet_list
  source              = "./all_terraform_modules/vnets"
  address_space       = [each.value["ip"]]
  base_name           = each.value["name"]
  location            = var.location
  resource_group_name = module.create_resource_group.resource_group_name_out

  network_security_group_id = module.create_nsg.nsg_out
  subnet_addr_prfx          = [each.value["subnet_ip"]]
}


resource "azurerm_subnet" "gw_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = module.create_resource_group.resource_group_name_out
  virtual_network_name = "${lookup(lookup(var.vnet_list, "vnet_03"), "name")}_VNET"
  address_prefixes     = ["172.16.20.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.base_name}_PUBLIC"
  location            = var.location
  resource_group_name = module.create_resource_group.resource_group_name_out
  allocation_method   = "Dynamic"

}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  name                = "${var.base_name}_NETWORK_GATEWAY"
  location            = var.location
  resource_group_name = module.create_resource_group.resource_group_name_out
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gw_subnet.id
  }
}
data "azurerm_virtual_network" "hub" {
  name                = "${lookup(lookup(var.vnet_list, "vnet_03"), "name")}_VNET"
  resource_group_name = module.create_resource_group.resource_group_name_out
  depends_on = [module.create_resource_group, module.create_vnet]
}

data "azurerm_virtual_network" "spoke_1" {
  name                = "${lookup(lookup(var.vnet_list, "vnet_01"), "name")}_VNET"
  resource_group_name = module.create_resource_group.resource_group_name_out
  depends_on = [module.create_resource_group, module.create_vnet]
}
data "azurerm_virtual_network" "spoke_2" {
  name                = "${lookup(lookup(var.vnet_list, "vnet_02"), "name")}_VNET"
  resource_group_name = module.create_resource_group.resource_group_name_out
  depends_on = [module.create_resource_group, module.create_vnet]
}
resource "azurerm_virtual_network_peering" "spoke_1_to_hub" {
  name                      = "spoke_1_to_hub"
  resource_group_name       = module.create_resource_group.resource_group_name_out
  virtual_network_name      = "${lookup(lookup(var.vnet_list, "vnet_01"), "name")}_VNET"
  remote_virtual_network_id = data.azurerm_virtual_network.hub.id
  use_remote_gateways       = true
  allow_forwarded_traffic = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_1" {
  name                      = "hub_to_spoke_1"
  resource_group_name       = module.create_resource_group.resource_group_name_out
  virtual_network_name      = "${lookup(lookup(var.vnet_list, "vnet_03"), "name")}_VNET"
  remote_virtual_network_id = data.azurerm_virtual_network.spoke_1.id
  allow_gateway_transit     = true
  allow_forwarded_traffic = true
}

resource "azurerm_virtual_network_peering" "spoke_2_to_hub" {
  name                      = "spoke_2_to_hub"
  resource_group_name       = module.create_resource_group.resource_group_name_out
  virtual_network_name      = "${lookup(lookup(var.vnet_list, "vnet_02"), "name")}_VNET"
  remote_virtual_network_id = data.azurerm_virtual_network.hub.id
  use_remote_gateways       = true
  allow_forwarded_traffic = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_2" {
  name                      = "hub_to_spoke_2"
  resource_group_name       = module.create_resource_group.resource_group_name_out
  virtual_network_name      = "${lookup(lookup(var.vnet_list, "vnet_03"), "name")}_VNET"
  remote_virtual_network_id = data.azurerm_virtual_network.spoke_2.id
  allow_gateway_transit     = true
  allow_forwarded_traffic = true
}