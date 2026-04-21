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
  subscription_id = "f581888a-e198-4db8-ac71-24910e81a209"

}