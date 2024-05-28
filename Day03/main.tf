terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3"
    }
  }
}
provider "azurerm" {
  features {

  }

}
resource "azurerm_resource_group" "rg" {
  name     = "rg-vm"
  location = "East US"

}
resource "azurerm_storage_account" "storage-account" {
  name                     = "storageaccountday02"
  resource_group_name      = "rg-vm"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  depends_on = [ azurerm_resource_group.rg ]

}