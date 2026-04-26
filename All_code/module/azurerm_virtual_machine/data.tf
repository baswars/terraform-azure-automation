data "azurerm_network_interface" "nic" {
  for_each            = var.linux_vm
  name                = each.value.name_nic
  resource_group_name = each.value.resource_group_name
}


data "azurerm_key_vault" "kv" {
  for_each            = var.linux_vm
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name

}
data "azurerm_key_vault_secret" "username" {
  for_each     = var.linux_vm
  name         = each.value.username_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id

}
data "azurerm_key_vault_secret" "password" {
  for_each     = var.linux_vm
  name         = each.value.password_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id

}