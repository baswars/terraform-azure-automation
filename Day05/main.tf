terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-vm"
    storage_account_name = "storageaccountday05"
    container_name = "storagecontainerday04"
    key = "terraform.tfstate"
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
  name                     = "storageaccountday05"
  resource_group_name      = "rg-vm"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  depends_on = [ azurerm_resource_group.rg ]

}
resource "azurerm_storage_container" "example" {
  name                  = "storagecontainerday04"
  storage_account_name  = azurerm_storage_account.storage-account.name
  container_access_type = "private"
}