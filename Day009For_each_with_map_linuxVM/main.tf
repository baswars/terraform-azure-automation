resource "azurerm_resource_group" "rg" {
  for_each = var.rg
  name     = each.value.name
  location = each.value.location
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet
  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_name].name
  location            = azurerm_resource_group.rg[each.value.resource_group_name].location
  address_space       = each.value.address_space

}
resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.rg[each.value.resource_group_name].name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.virtual_network].name
  address_prefixes     = each.value.address_prefixes
}
resource "azurerm_public_ip" "pip" {
  for_each            = var.pip
  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_name].name
  location            = azurerm_resource_group.rg[each.value.resource_group_name].location
  allocation_method   = each.value.allocation_method
}
resource "azurerm_network_interface" "nic" {
  for_each            = var.nic
  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_name].name
  location            = azurerm_resource_group.rg[each.value.resource_group_name].location
  ip_configuration {
    name                          = each.value.ip_config_name
    subnet_id                     = azurerm_subnet.subnet[each.value.subnet].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.pip[each.value.pip].id
  }

}
resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.linux_vm
  name                            = each.value.name
  resource_group_name             = azurerm_resource_group.rg[each.value.resource_group].name
  location                        = azurerm_resource_group.rg[each.value.resource_group].location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids = [
    azurerm_network_interface.nic[each.value.nic].id
  ]

  os_disk {
    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_storage_account_type

  }
  source_image_reference {
    publisher = each.value.source_image_publisher
    offer     = each.value.source_image_offer
    sku       = each.value.source_image_sku
    version   = each.value.source_image_version
  }

}