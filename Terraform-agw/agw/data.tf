data "azurerm_subnet" "subnet" {
    for_each = var.agw
  name                 = each.value.subnet-name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_network_interface" "nic1" {
    for_each = var.agw
  name                = each.value.nic-name1
  resource_group_name = each.value.resource_group_name
}
data "azurerm_network_interface" "nic2" {
    for_each = var.agw
  name                = each.value.nic-name2
  resource_group_name = each.value.resource_group_name
}


