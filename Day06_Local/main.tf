terraform {
  required_providers { # This block specifies the providers that Terraform will use to manage resources. 
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }
  backend "azurerm" { # This block configures the backend for storing Terraform state files. 
    resource_group_name  = "rg-backend"
    storage_account_name = "storageaccobackend"
    container_name       = "storagecontainerbackend"
    key                  = "terraform.tfstate"

  }
}
provider "azurerm" { # This block configures the Azure Resource Manager provider, which allows Terraform to manage Azure resources.
  features {

  }

}

locals {
  location              = "West Europe"
  resource_group_name   = "rg-day04"
  vnet_name             = "vnet-day04"
  subnet_name           = "subnet1"
  address_prefix        = "10.0.0.0/16"
  subnet_address_prefix = "10.0.1.0/24"
  public_ip_name        = "pip-day04"
  nic_name              = "nic-day04"
  nsg_name              = "nsg-day04"
  nsg_rule_name         = "SSH"
  vm_name               = "linuxvm-day04"

  tags = {
    environment = "dev"
    project     = "terraform-azure-automation"
  }
}

resource "azurerm_resource_group" "rg" { # This block defines an Azure Resource Group resource. 
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags

}

resource "azurerm_virtual_network" "vnet" { # This block defines an Azure Virtual Network resource.
  name                = local.vnet_name
  resource_group_name = azurerm_resource_group.rg.name     # implicit dependency on resource group
  location            = azurerm_resource_group.rg.location # implicit dependency on resource group
  address_space       = [local.address_prefix]
  tags                = local.tags

}

resource "azurerm_subnet" "subnet1" { # This block defines an Azure Subnet resource.
  name                 = local.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.subnet_address_prefix]
}

resource "azurerm_public_ip" "pip" { # This block defines an Azure Public IP Address resource.
  name                = local.public_ip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

}

resource "azurerm_network_interface" "nic" { # This block defines an Azure Network Interface resource.
  name                = local.nic_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet1.id # implicit dependency on subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id # implicit dependency on public IP
  }
  depends_on = [azurerm_subnet.subnet1]

}

resource "azurerm_network_security_group" "nsg" { # This block defines an Azure Network Security Group resource, 
  name                = local.nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = local.nsg_rule_name # This rule allows inbound SSH traffic on port 22 from any source to any destination. 
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22" # This rule allows inbound SSH traffic on port 22 from any source to any destination.
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" { # This block associates the NSG with the subnet
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on                = [azurerm_subnet.subnet1]
}
resource "azurerm_network_interface_security_group_association" "nsg_associationNic" { # This block associates the NSG with the network interface
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on                = [azurerm_network_interface.nic]
}


resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                            = local.vm_name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_D4s_v3"
  admin_username                  = "adminuser"
  admin_password                  = "AdminPassword123!"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]


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