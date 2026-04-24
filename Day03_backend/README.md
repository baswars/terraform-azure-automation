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
  terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-backend"
    storage_account_name = "storageaccobackend"
    container_name = "storagecontainerbackend"
    key = "terraform.tfstate"
  }
}
}

backend:

In Terraform, a backend is used to define where the Terraform state file is stored. By default, it’s stored locally, but in real projects we use a remote backend for better collaboration and security.

In my case, I used the Azure backend, where the state file is stored in an Azure Storage Account inside a blob container.


# Components of the backend Block

resource_group_name: The name of the resource group where the storage account is located.
storage_account_name: The name of the Azure Storage Account where the Terraform state file will be stored.
container_name: The name of the container within the storage account to store the state file.
key: The name of the state file. This is the path within the container where the state file will be stored.

**Benefits of Using a Backend**
**Collaboration**: Enables multiple team members to work on the same Terraform configurations by sharing the state file.
**Locking**: Prevents concurrent operations that could potentially corrupt the state file using state locking mechanisms.
**Security**: Stores the state file in a secure and managed location, benefiting from Azure Storage's security features.
**Consistency**: Ensures that everyone is working from the same state, avoiding discrepancies and conflicts.

# How to Use the Backend
Initialize the Backend: When you run terraform init, Terraform will initialize the backend and configure it to use the specified Azure Storage Account.
Apply Configuration: When you run terraform apply, Terraform will store the state file in the specified Azure Storage Account.
Manage State: The state file will be automatically managed and updated in the remote backend.


When I run terraform init, Terraform connects to this storage account and stores the state remotely instead of locally.

This helps in:

Centralized state management
Team collaboration
Avoiding conflicts using state locking

So overall, backend ensures that Terraform state is stored securely and can be shared across teams and pipelines.


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
  name     = "rg-day03"
  location = "East US"
}
resource "azurerm_resource_group" "rg": Defines an Azure Resource Group resource.
name: The name of the resource group (rg-day03).
location: The Azure region where the resource group will be created (East US).

4) **Storage Account**
The resource block defines the Azure Storage Account that will be created within the specified resource group.

resource "azurerm_storage_account" "storage-account" {
  name                     = "storageaccountday03"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  depends_on               = [azurerm_resource_group.rg]
}

resource "azurerm_storage_account" "storage-account": Defines an Azure Storage Account resource.
name: The name of the storage account (storageaccountday03). This name must be globally unique.
resource_group_name: The name of the resource group where the storage account will be created.
location: The Azure region where the storage account will be created.
account_tier: The performance tier of the storage account (Standard).
account_replication_type: The replication strategy for the storage account (GRS), which stands for Geo-Redundant Storage.
depends_on: Ensures that the storage account is created only after the resource group has been successfully created.

5) **Dependencies**

In Terraform, a dependency defines the order in which resources are created, updated, or destroyed.

Terraform builds a dependency graph (DAG) internally and ensures that resources are provisioned in the correct sequence.

There are two types of dependencies:

Implicit dependency – This is automatically handled by Terraform when one resource references another.
For example, if a Virtual Network uses a Resource Group name, Terraform knows the Resource Group must be created first.
Explicit dependency (depends_on) – This is manually defined when Terraform cannot detect the dependency on its own.
It forces Terraform to create resources in a specific order.

In real projects, I mostly rely on implicit dependencies, and I use depends_on only in special cases like provisioners or when working with external resources.

