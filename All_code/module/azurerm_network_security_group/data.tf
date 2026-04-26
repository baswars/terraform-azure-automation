data "azurerm_subnet" "subnet" {
  for_each             = var.nsg
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_network_interface" "nic" {
  for_each            = var.nsg
  name                = each.value.name_nic
  resource_group_name = each.value.resource_group_name
}