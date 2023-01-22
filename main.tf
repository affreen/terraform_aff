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
  for_each            = var.vnet_list
  source              = "./all_terraform_modules/vnets"
  address_space       = [each.value["ip"]]
  base_name           = each.value["name"]
  location            = var.location
  resource_group_name = module.create_resource_group.resource_group_name_out

}
