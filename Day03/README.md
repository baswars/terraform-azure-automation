Terraform Configuration for Azure Storage Account

This repository contains Terraform code to create an Azure Resource Group and a Storage Account. The configuration uses explicit dependencies to ensure proper resource creation order.

Prerequisites
Before using this Terraform configuration, ensure you have:

1) An Azure account.
2) Terraform installed on your local machine.
3) zure CLI installed and authenticated.
4) Configuration Details

1) ** Terraform Block**
The terraform block specifies the required providers and their versions. In this configuration, we are using the Azure Resource Manager (azurerm) provider.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3"
    }
  }
}

required_providers: Specifies the providers Terraform needs.
azurerm: The Azure Resource Manager provider.
source: Indicates the provider source, which is hashicorp/azurerm.
version: Specifies the version constraint. Here, it requires version 3.0.0 or above.

2) **Provider Block**
The provider block configures the specified provider. In this case, it's configuring the Azure provider.

provider "azurerm" {
  features {}
}
provider "azurerm": Configures the Azure Resource Manager provider.
features {}: This block is required but can be left empty unless specific features need to be configured.

3) **Resource Group**
Before creating the storage account, we need to define a resource group. Here is the configuration for the resource group:

resource "azurerm_resource_group" "rg" {
  name     = "rg-vm"
  location = "East US"
}
resource "azurerm_resource_group" "rg": Defines an Azure Resource Group resource.
name: The name of the resource group (rg-vm).
location: The Azure region where the resource group will be created (East US).

4) **Storage Account**
The resource block defines the Azure Storage Account that will be created within the specified resource group.

resource "azurerm_storage_account" "storage-account" {
  name                     = "storageaccountday02"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  depends_on               = [azurerm_resource_group.rg]
}

resource "azurerm_storage_account" "storage-account": Defines an Azure Storage Account resource.
name: The name of the storage account (storageaccountday02). This name must be globally unique.
resource_group_name: The name of the resource group where the storage account will be created.
location: The Azure region where the storage account will be created.
account_tier: The performance tier of the storage account (Standard).
account_replication_type: The replication strategy for the storage account (GRS), which stands for Geo-Redundant Storage.
depends_on: Ensures that the storage account is created only after the resource group has been successfully created.

5) **Dependencies**
This configuration explicitly defines dependencies to ensure the proper creation order of resources. The storage account depends on the resource group, specified using the depends_on argument.

Usage
To use this Terraform configuration, follow these steps:

Clone the Repository:

git clone https://github.com/yourusername/terraform-azure-automation.git
cd terraform-azure-automation

Initialize Terraform:
Initialize the working directory containing the Terraform configuration files. This will download the necessary provider plugins.

**terraform init**
Plan the Deployment:
Generate and show an execution plan. This helps you understand what Terraform will do when you apply the configuration.

**terraform plan**
Apply the Configuration:
Apply the changes required to reach the desired state of the configuration. This will create the resource group and storage account in your Azure subscription.


**terraform apply**
Verify the Resources:
After the apply completes, you can verify the resource group and storage account creation in the Azure portal.

Clean Up
To remove the resources created by this configuration, you can run:

**terraform destroy**
This command will delete all the resources defined in your Terraform configuration.

Contributing
We welcome contributions to enhance and expand the capabilities of this repository. Please follow these steps to contribute:

Fork the repository.
Create a new branch for your feature or bugfix.
Make your changes and commit them with clear commit messages.
Push your changes to your forked repository.
Create a pull request to merge your changes into the main repository.