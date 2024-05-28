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
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}