terraform {
  required_providers { # This block specifies the providers that Terraform will use to manage resources. 
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }
  backend "azurerm" { # This block configures the backend for storing Terraform state files. 
    resource_group_name  = "rg-backend"
    storage_account_name = "storageaccobackend"
    container_name       = "storagecontainerbackend"
    key                  = "terraform.tfstate"

  }
}
provider "azurerm" { # This block configures the Azure Resource Manager provider, which allows Terraform to manage Azure resources.
  features {
  }
}
