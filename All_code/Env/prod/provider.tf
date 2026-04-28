terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
  # backend "azurerm" { # This block configures the backend for storing Terraform state files. 
  #   resource_group_name  = "rg-backend"
  #   storage_account_name = "storageaccobackend"
  #   container_name       = "storagecontainerbackend"
  #   key                  = "terraform.tfstate"

  # }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets          = true
    }
  }
}