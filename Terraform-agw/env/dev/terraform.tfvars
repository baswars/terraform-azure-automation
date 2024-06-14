rg = {
  rg1 = {
    name     = "rg-agw"
    location = "East US"
  }
}
vnet = {
  vnet1 = {

    name                = "vnet-agw"
    location            = "East US"
    resource_group_name = "rg-agw"
    address_space       = ["10.0.0.0/16"]
  }
}
subnet = {
  subnet1 = {
    name                 = "subnet-vm1"
    resource_group_name  = "rg-agw"
    virtual_network_name = "vnet-agw"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "subnet-vm2"
    resource_group_name  = "rg-agw"
    virtual_network_name = "vnet-agw"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "subnet-agw"
    resource_group_name  = "rg-agw"
    virtual_network_name = "vnet-agw"
    address_prefixes     = ["10.0.3.0/24"]
  }
  subnet4 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-agw"
    virtual_network_name = "vnet-agw"
    address_prefixes     = ["10.0.4.0/26"]
  }
}
nic = {
  nic1 = {
    name                          = "nic-vm1"
    location                      = "East US"
    resource_group_name           = "rg-agw"
    ip-conf-name                  = "Internal"
    subnet-name                   = "subnet-vm1"
    private_ip_address_allocation = "Dynamic"
    virtual_network_name          = "vnet-agw"

  }
  nic2 = {
    name                          = "nic-vm2"
    location                      = "East US"
    resource_group_name           = "rg-agw"
    ip-conf-name                  = "Internal"
    subnet-name                   = "subnet-vm2"
    private_ip_address_allocation = "Dynamic"
    virtual_network_name          = "vnet-agw"
  }

}
vm = {
  vm1 = {
    name                            = "vm1"
    location                        = "East US"
    resource_group_name             = "rg-agw"
    size                            = "Standard_F2"
    admin_username                  = "India"
    admin_password                  = "India@123"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
    nic-name                        = "nic-vm1"

  }
  vm2 = {
    name                            = "vm2"
    location                        = "East US"
    resource_group_name             = "rg-agw"
    size                            = "Standard_F2"
    admin_username                  = "India"
    admin_password                  = "India@123"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
    nic-name                        = "nic-vm2"

  }
}
bastion = {
  bastion1 = {
    pip-name             = "pip-bastion-host"
    location             = "East US"
    resource_group_name  = "rg-agw"
    allocation_method    = "Static"
    sku                  = "Standard"
    name                 = "bastion-host"
    ip-conf-name         = "Internal"
    subnet-name          = "AzureBastionSubnet"
    virtual_network_name = "vnet-agw"

  }
}
agw = {
  agw1 = {
    pip-name             = "pip-agw"
    location             = "East US"
    resource_group_name  = "rg-agw"
    name                 = "agw"
    subnet-name         = "subnet-agw"
    virtual_network_name = "vnet-agw"
    nic-name1="nic-vm1"
    nic-name2="nic-vm2"


  }
}