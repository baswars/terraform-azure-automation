resource "azurerm_resource_group" "rg" {
  name     = "rg-dynamic"
  location = "eastus"

}

# resource "azurerm_virtual_network" "vnet" {
#   name                = "vnet-dynamic"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   address_space       = ["10.0.0.0/16"]

#   # subnet { #  we can not use this method to create multiple subnets because it will override one
#   #   name             = "subnet1"
#   #   address_prefixes = ["10.0.1.0/24"]
#   # }

#   # subnet {
#   #   name             = "subnet2"
#   #   address_prefixes = ["10.0.2.0/24"]
#   # }

#   # subnet {
#   #   name             = "subnet3"
#   #   address_prefixes = ["10.0.3.0/24"]
#   # }
#   # subnet {
#   #   name             = "subnet4"
#   #   address_prefixes = ["10.0.4.0/24"]
#   # }

# }

variable "subnets" { # we can use this method to create multiple subnets because it will not override the previous one
  default = [
    {
      name           = "subnet1"
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "subnet2"
      address_prefix = "10.0.2.0/24"
    },
    {
      name           = "subnet3"
      address_prefix = "10.0.3.0/24"
    },
    {
      name           = "subnet4"
      address_prefix = "10.0.4.0/24"
    }
  ]
}
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-dynamic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  dynamic "subnet" { # dynamic block is used to create multiple subnets
    for_each = var.subnets
    content {
      name             = subnet.value.name
      address_prefixes = [subnet.value.address_prefix]
    }

  }

}