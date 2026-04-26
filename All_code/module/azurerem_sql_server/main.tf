
resource "azurerm_mssql_server" "server" {
  for_each                     = var.mssqlserver
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.username[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.password[each.key].value
  minimum_tls_version          = each.value.minimum_tls_version

}