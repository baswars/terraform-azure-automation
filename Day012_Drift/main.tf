resource "azurerm_resource_group" "rg-vm" {
  name     = "rg-vm1"
  location = "eastus"

  # lifecycle {
  #   prevent_destroy = true
  #   ignore_changes  = [tags]
  # }
  tags = {
  env = "dev"
  }

}


resource "azurerm_storage_account" "storageaccount" {
  name                     = "storageaccoutmyvm1"
  location                 = azurerm_resource_group.rg-vm.location # implicit dependency i used here, terraform will understand that storage account depends on resource group
  resource_group_name      = azurerm_resource_group.rg-vm.name # implicit dependency i used here, terraform will understand that storage account depends on resource group
  account_replication_type = "LRS"
  account_tier             = "Standard"

  # lifecycle {
  #   prevent_destroy = true
  # }

}

output "resource_group_id" {          # output block to get the resource group id
  value = azurerm_resource_group.rg-vm.id
}


output "storage_account_id" {       # output block to get the storage account id
  value = azurerm_storage_account.storageaccount.id

}

resource "azurerm_storage_container" "storagecontainer" { # creating a storage container inside the storage account
  name                  = "storagecontainer1"
  storage_account_id    = azurerm_storage_account.storageaccount.id # implicit dependency i used here, terraform will understand that storage container depends on storage account
  container_access_type = "private"

}

