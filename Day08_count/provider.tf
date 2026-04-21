terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
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

  features { }
}
