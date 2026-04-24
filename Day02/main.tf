terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }
}
provider "azurerm" {
  features {

  }
  subscription_id = "a863c08a-12ed-48e5-a659-57ef8bbfe98c"

}
resource "azurerm_resource_group" "rg" {
  name     = "rg-backend"
  location = "East US"

}
resource "azurerm_storage_account" "storage-account" {
  name                     = "storageaccobackend"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}
resource "azurerm_storage_container" "example" {
  name                  = "storagecontainerbackend"
  storage_account_id    = azurerm_storage_account.storage-account.id
  container_access_type = "private"
}