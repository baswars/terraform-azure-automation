terraform {
  required_providers {
    azurrmrm = {
      source  = "hashicorp/azurerm"
      version = ">3"
    }
  }
}
provider "azurrmrm" {
  features {

  }

}
resource "azurerm_resource_group" "rg" {
  name     = "rg-vm"
  location = "East US"

}