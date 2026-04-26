terraform {
  backend "azurerm" { # This block configures the backend for storing Terraform state files. 
    resource_group_name  = "rg-backend"
    storage_account_name = "storageaccobackend"
    container_name       = "storagecontainerbackend"
    key                  = "terraform.tfstate"

  }
}