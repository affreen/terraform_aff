terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.39.1"
    }
  }
}

provider "azurerm" {
 features {}
}

resource "azurerm_resource_group" "Affreen_RG" {
  name     = "Affreen_RG"
  location = "West Europe"
}