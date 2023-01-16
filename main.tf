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

module "create_vnet" {
  source              = "./all_terraform_modules/vnets"
  address_space       = var.address_space
  base_name           = var.base_name
  location            = var.location
  resource_group_name = module.create_resource_group.resource_group_name_out

}

module "create_subnet" {
  for_each = var.subnet_list
  source               = "./all_terraform_modules/subnets"
  base_name            = each.value["name"]
  resource_group_name  = module.create_resource_group.resource_group_name_out
  virtual_network_name = module.create_vnet.vnet_out
  subnet_addr_prfx     = [each.value["ip"]]
  network_security_group_id = module.create_nsg.nsg_out
}

module "create_nsg" {
  source              = "./all_terraform_modules/network_security_groups"
  base_name           = var.base_name
  location            = var.location
  resource_group_name = module.create_resource_group.resource_group_name_out
  #network_security_grp_name = var.network_security_grp_name
  nsg_rules = var.nsg_rules

}


