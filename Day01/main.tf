terraform {
  required_providers {
    azurrmrm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
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