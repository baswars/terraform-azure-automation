output "resource_group_ids" {
  value = {
    for k, rg in azurerm_resource_group.rg :
    k => rg.id
  }
}
