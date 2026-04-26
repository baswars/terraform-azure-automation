data "azurerm_mssql_server" "server" {
  for_each            = var.mssqldatabase
  name                = each.value.server_name
  resource_group_name = each.value.resource_group_name
}