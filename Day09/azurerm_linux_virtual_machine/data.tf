data "azurerm_network_interface" "nic" {
    for_each = var.vm
  name                = each.value.nic-name
  resource_group_name = each.value.resource_group_name
}
