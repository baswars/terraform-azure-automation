resource "azurerm_resource_group" "rg" {
  name     = "rg-vm"
  location = "south India"

}
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]

}
resource "azurerm_subnet" "subnet" {
  count                = 4
  name                 = "subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.${count.index}.0/24"]

}
resource "azurerm_network_interface" "nic" {
  count               = 4
  name                = "nic-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "Internal-${count.index}"
    subnet_id                     = azurerm_subnet.subnet[count.index].id
    private_ip_address_allocation = "Dynamic"

  }

}
resource "azurerm_linux_virtual_machine" "vm" {
  count                           = 4
  name                            = "vm-${count.index}"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  size                            = "Standard_F2"
  admin_username                  = "India"
  admin_password                  = "India@2020"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic[count.index].id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
