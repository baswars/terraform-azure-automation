resource "azurerm_mssql_database" "database" {
  for_each     = var.mssqldatabase
  name         = each.value.name
  server_id    = data.azurerm_mssql_server.server[each.key].id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"


  #   # prevent the possibility of accidental data loss
  #   lifecycle {
  #     prevent_destroy = true
  #   }
}