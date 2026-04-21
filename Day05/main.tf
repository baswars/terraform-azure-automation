terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name = "rg-vm"
  #   storage_account_name = "storageaccountday05"
  #   container_name = "storagecontainerday04"
  #   key = "terraform.tfstate"
  # }
}
provider "azurerm" {
  features {

  }
  subscription_id = "f581888a-e198-4db8-ac71-24910e81a209"

}
resource "azurerm_resource_group" "rg" {
  name     = "rg-vm"
  location = "East US"

}
resource "azurerm_storage_account" "storageaccount" {
  name                     = "storageaccountday05"
  resource_group_name      = "rg-vm"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  depends_on               = [azurerm_resource_group.rg]

}
resource "azurerm_storage_container" "container" {
  name                  = "storagecontainerday04"
  storage_account_id    = azurerm_storage_account.storageaccount.id
  container_access_type = "private"
}