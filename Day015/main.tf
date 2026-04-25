
resource "azurerm_resource_group" "rg" { # This block defines an Azure Resource Group resource. 
  name     = var.rg_name
  location = var.location

}

resource "azurerm_virtual_network" "vnet" { # This block defines an Azure Virtual Network resource.
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name     # implicit dependency on resource group
  location            = azurerm_resource_group.rg.location # implicit dependency on resource group
  address_space       = var.address_space

}

resource "azurerm_subnet" "subnet1" { # This block defines an Azure Subnet resource.
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_public_ip" "pip" { # This block defines an Azure Public IP Address resource.
  name                = var.pip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = var.pip_allocation_method

}

resource "azurerm_network_interface" "nic" { # This block defines an Azure Network Interface resource.
  name                = var.nic_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = var.ip_config
    subnet_id                     = azurerm_subnet.subnet1.id # implicit dependency on subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id # implicit dependency on public IP
  }

}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                            = var.vm_name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.disable_password_authentication
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]


  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.version_vm
  }
}