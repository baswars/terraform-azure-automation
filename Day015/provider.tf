terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }

  }
}

provider "azurerm" {
  features {}
  subscription_id = "a863c08a-12ed-48e5-a659-57ef8bbfe98c"

}