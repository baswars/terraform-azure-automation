terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-backend"
    storage_account_name = "storageaccobackend"
    container_name       = "storagecontainerbackend"
    key                  = "terraform.tfstate"

  }
}
provider "azurerm" {
  features {

  }

}
resource "azurerm_resource_group" "rg" {
  name     = "rg-day03"
  location = "East US"

}
resource "azurerm_storage_account" "storage-account" {
  name                     = "storageaccoday03"
  resource_group_name      = azurerm_resource_group.rg.name # implicit dependency on resource group
  location                 = azurerm_resource_group.rg.location # implicit dependency on resource group
  account_tier             = "Standard" # Standard storage accounts are backed by magnetic drives and are suitable for most scenarios. They offer lower cost compared to Premium storage accounts, which are backed by solid-state drives (SSDs) and provide higher performance. Standard storage accounts are ideal for general-purpose workloads, such as storing files, blobs, queues, and tables.
  account_replication_type = "GRS" # Geo-redundant storage (GRS) replicates your data asynchronously to a secondary region hundreds of miles away from the primary location of the source data. In the event of a regional outage, Microsoft will failover to the secondary region, and you can access your data there. GRS is designed to provide 99.99999999999999% durability of objects over a given year.
  

}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-day03"
  resource_group_name = azurerm_resource_group.rg.name     # implicit dependency on resource group
  location            = azurerm_resource_group.rg.location # implicit dependency on resource group
  address_space       = ["10.0.0.0/16"] 

}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

}
resource "azurerm_subnet" "subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}