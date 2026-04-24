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

# 🔹 Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-vmss"
  location = "West Europe"
}

# 🔹 Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-vmss"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# 🔹 Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-vmss"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 🔹 Linux VM Scale Set
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "vmss-linux"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_D2ls_v5"
  instances           = 2
  admin_username      = "adminuser"

  admin_password                  = "AdminPassword123!"
  disable_password_authentication = false

  # 🔹 OS Disk
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  # 🔹 Image
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # 🔹 Network Interface
  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet.id

    }

  }

}