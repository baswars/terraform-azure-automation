module "azurerm_resource_group" {
  source         = "../../module/azurerm_resource_group"
  resource_group = var.resource_group1

}
module "azurerm_storage_account" {
  source          = "../../module/azurerm_storage_account"
  storage_account = var.storage_account
  depends_on      = [module.azurerm_resource_group]

}

module "azurerm_virtual_network" {
  source          = "../../module/azurerm_virtual_network"
  virtual_network = var.virtual_network1
  depends_on      = [module.azurerm_resource_group]

}

module "azurerm_subnet" {
  source     = "../../module/azurerm_subnet"
  subnet     = var.subnet
  depends_on = [module.azurerm_virtual_network]
}

module "azurerm_public_ip" {
  source     = "../../module/azurerm_public_ip"
  pip        = var.pip
  depends_on = [module.azurerm_resource_group]
}
module "azurerm_network_interface" {
  source     = "../../module/azurerm_network_inteface"
  nic        = var.nic
  depends_on = [module.azurerm_resource_group, module.azurerm_public_ip, module.azurerm_subnet]

}
module "azurerm_linux_virtual_machine" {
  source     = "../../module/azurerm_virtual_machine"
  linux_vm   = var.linux_vm
  depends_on = [module.azurerm_network_interface, module.azurerm_resource_group, module.azurerm_network_security_group, module.azurerm_key_vault]
}
module "azurerm_network_security_group" {
  source     = "../../module/azurerm_network_security_group"
  nsg        = var.nsg
  depends_on = [module.azurerm_network_interface, module.azurerm_subnet, module.azurerm_resource_group, module.azurerm_key_vault]

}
module "azurerm_key_vault" {
  source     = "../../module/azurerm_key_vault"
  kayv       = var.kayv
  depends_on = [module.azurerm_resource_group]
}
module "azurerm_bastion_host" {
  source     = "../../module/azurerm_bastion_host"
  bastion    = var.bastion
  depends_on = [module.azurerm_public_ip, module.azurerm_subnet, module.azurerm_resource_group]

}
module "azurerm_mssql_server" {
  source      = "../../module/azurerem_sql_server"
  mssqlserver = var.mssqlserver
  depends_on  = [module.azurerm_resource_group, module.azurerm_key_vault]

}
module "azurerm_mssql_database" {
  source        = "../../module/azurerm_mssql_database"
  mssqldatabase = var.mssqldatabase
  depends_on    = [module.azurerm_mssql_server, module.azurerm_resource_group]

}
module "azurerm_container_registry" {
  source     = "../../module/azurerm_container_registry"
  acr        = var.acr
  depends_on = [module.azurerm_resource_group]

}
module "azurerm_kubernetes_service" {
  source     = "../../module/azurerm_kubernetes_service"
  aks        = var.aks
  depends_on = [module.azurerm_resource_group, module.azurerm_container_registry, module.azurerm_key_vault]
}