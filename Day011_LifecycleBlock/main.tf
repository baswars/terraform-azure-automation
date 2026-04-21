resource "azurerm_resource_group" "rg-vm" {
  name     = "rg-vm1"
  location = "eastus"

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }
  tags = {
    environment = "dev"
  }

}


resource "azurerm_storage_account" "storageaccount" {
  name                     = "storageaccoutmyvm1"
  location                 = azurerm_resource_group.rg-vm.location
  resource_group_name      = azurerm_resource_group.rg-vm.name
  account_replication_type = "LRS"
  account_tier             = "Standard"

  lifecycle {
    prevent_destroy = true
  }

}

output "resource_group_id" {
  value = azurerm_resource_group.rg-vm.id
}


output "storage_account_id" {
  value = azurerm_storage_account.storageaccount.id

}