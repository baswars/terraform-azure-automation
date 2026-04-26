rg = {
  "rg1" = {
    name     = "rg1"
    location = "West Europe"
  }
  "rg2" = {
    name     = "rg2"
    location = "South India"
  }
}

vnet = {
  vnet1 = {
    name                = "vnet-vm"
    resource_group_name = "rg1"
    location            = "West Europe"
    address_space       = ["10.0.0.0/16"]
  }
  vnet2 = {
    name                = "vnet-vm2"
    resource_group_name = "rg2"
    location            = "South India"
    address_space       = ["10.1.0.0/16"]
  }
}
subnet = {
  subnet1 = {
    name                = "subnet-vm"
    resource_group_name = "rg1"
    virtual_network     = "vnet1"
    address_prefixes    = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                = "subnet-vm2"
    resource_group_name = "rg2"
    virtual_network     = "vnet2"
    address_prefixes    = ["10.1.1.0/24"]
  }
}
pip = {
  pip1 = {
    name                = "pip-vm"
    resource_group_name = "rg1"
    location            = "West Europe"
    allocation_method   = "Static"
  }
  pip2 = {
    name                = "pip-vm2"
    resource_group_name = "rg2"
    location            = "South India"
    allocation_method   = "Static"
  }
}
nic = {
  nic1 = {
    name                          = "nic-vm"
    resource_group_name           = "rg1"
    location                      = "West Europe"
    ip_config_name                = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet                        = "subnet1"
    pip                           = "pip1"
  }
  nic2 = {
    name                          = "nic-vm2"
    resource_group_name           = "rg2"
    location                      = "South India"
    ip_config_name                = "ipconfig2"
    private_ip_address_allocation = "Dynamic"
    subnet                        = "subnet2"
    pip                           = "pip2"
  }
}
linux_vm = {
  vm1 = {
    name                            = "linuxvm"
    resource_group                  = "rg1"
    location                        = "West Europe"
    size                            = "Standard_D4s_v3"
    admin_username                  = "azureuser"
    admin_password                  = "P@ssw0rd1234!"
    disable_password_authentication = false
    os_disk_caching                 = "ReadWrite"
    os_disk_storage_account_type    = "Standard_LRS"
    source_image_publisher          = "Canonical"
    source_image_offer              = "UbuntuServer"
    source_image_sku                = "18.04-LTS"
    source_image_version            = "latest"
    nic                             = "nic1"
  }
  vm2 = {
    name                            = "linuxvm2"
    resource_group                  = "rg2"
    location                        = "South India"
    size                            = "Standard_D4s_v3"
    admin_username                  = "azureuser"
    admin_password                  = "P@ssw0rd1234!"
    disable_password_authentication = false
    os_disk_caching                 = "ReadWrite"
    os_disk_storage_account_type    = "Standard_LRS"
    source_image_publisher          = "Canonical"
    source_image_offer              = "UbuntuServer"
    source_image_sku                = "18.04-LTS"
    source_image_version            = "latest"
    nic                             = "nic2"
  }
}