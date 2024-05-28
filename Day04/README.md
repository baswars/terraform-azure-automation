# Terraform Azure Resource Deployment

This Terraform configuration automates the deployment of Azure resources using Azure Resource Manager.

**Prerequisites**
Before you begin, ensure you have the following:

Terraform installed on your local machine.
An Azure account with appropriate permissions.
Azure CLI installed and authenticated.

**Configuration Overview**
This Terraform configuration will:
Create an Azure resource group in the East US region.
Create a standard Azure Storage Account with GRS replication.
Create a private storage container within the storage account.

**Terraform Configuration**

**Terraform Block**
The terraform block specifies the required providers and their versions. It defines that the configuration depends on the Azure provider version 3 or higher.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3"
    }
  }
}

**Provider Block**
The provider block configures the Azure provider.

provider "azurerm" {
  features {}
}

**Resource Group**

Defines an Azure Resource Group resource.
resource "azurerm_resource_group" "rg" {
  name     = "rg-vm"
  location = "East US"
}

**Storage Account**

Defines an Azure Storage Account resource with GRS replication.
resource "azurerm_storage_account" "storage-account" {
  name                     = "storageaccountday04"
  resource_group_name      = "rg-vm"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  depends_on               = [azurerm_resource_group.rg]
}

**Storage Container**

Defines an Azure Storage Container resource within the storage account.

resource "azurerm_storage_container" "example" {
  name                  = "storagecontainerday04"
  storage_account_name  = azurerm_storage_account.storage-account.name
  container_access_type = "private"
}

A Storage Container is a logical unit in which data is stored within an Azure Storage Account. It provides a way to organize and manage data within the storage account. In this configuration, a private storage container is created within the Azure Storage Account to store files or objects securely.

**Usage**

Clone this repository to your local machine.

Replace any placeholder values in the Terraform files with your desired configurations.
Run terraform init to initialize the working directory.
Run terraform plan to generate an execution plan.
Run terraform apply to apply the configuration and create the Azure resources.
Verify the resources in the Azure portal.

**Clean Up**
To remove the resources created by this configuration, run terraform destroy after you're done using them.

**Contributing**
Contributions to enhance and improve this Terraform configuration are welcome! Feel free to fork this repository, make changes, and submit a pull request.