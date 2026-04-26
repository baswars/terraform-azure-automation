resource "azurerm_key_vault" "kv" {
  for_each                    = var.kayv
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = each.value.sku_name
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = false
  enabled_for_disk_encryption = true
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "List",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "List",
      "Recover"
    ]
    storage_permissions = [
      "Get"
    ]
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "username" {
  for_each     = var.kayv
  name         = "username"
  value        = "sachin"
  key_vault_id = azurerm_key_vault.kv[each.key].id
}
resource "azurerm_key_vault_secret" "password" {
  for_each     = var.kayv
  name         = "password"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.kv[each.key].id
}