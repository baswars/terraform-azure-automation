Terraform Configuration for Azure Infrastructure
This Terraform configuration file sets up an Azure infrastructure including a resource group, virtual network, subnet, public IP, network interface, network security group, and a Windows virtual machine.

Prerequisites
Terraform installed
An Azure account
Provider Configuration
The configuration specifies the azurerm provider with version 3 or higher.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3"
    }
  }
}

provider "azurerm" {
  features {}
}
Resources
Resource Group

Creates a resource group named rg-vm in the East US region.

resource "azurerm_resource_group" "rg" {
  name     = "rg-vm"
  location = "East US"
}
Virtual Network

Creates a virtual network named vnet-vm within the resource group.

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}
Subnet

Creates a subnet named subnet-vm within the virtual network.


resource "azurerm_subnet" "subnet" {
  name                 = "subnet-vm"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
Public IP

Creates a static public IP named pip-vm.


resource "azurerm_public_ip" "pip" {
  name                = "pip-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
  Network Interface

Creates a network interface named nic-vm and assigns the public IP and subnet.

resource "azurerm_network_interface" "nic" {
  name                = "nic-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "Internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}
Network Security Group

Creates a network security group named nsg-vm with security rules.

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "test1234"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
Associations

Associates the network security group with the subnet and network interface.


resource "azurerm_subnet_network_security_group_association" "nsg-subnet" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface_security_group_association" "nsg-nic" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
Windows Virtual Machine

Creates a Windows virtual machine named windows-vm.

resource "azurerm_windows_virtual_machine" "windows-vm" {
  name                  = "windows-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = "Standard_F2"
  admin_password        = "Test@2020"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
Usage
Initialize Terraform:


terraform init
Plan the Infrastructure:

terraform plan
Apply the Configuration:


terraform apply
Notes
Ensure your Azure credentials are configured before running the Terraform commands.
The admin password for the virtual machine should be changed to a secure value.
License
This project is licensed under the MIT License. See the LICENSE file for details.





