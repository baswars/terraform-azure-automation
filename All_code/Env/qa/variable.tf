variable "resource_group1" {
  type = map(object({
    name     = string
    location = string

  }))

}

variable "storage_account" {
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    container_name           = string
    container_access_type    = string

  }))

}

variable "virtual_network1" {
  type = map(object({

    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)

  }))

}

variable "subnet" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))

}

variable "pip" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    sku                 = string
  }))

}
variable "nic" {
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    private_ip_address_allocation = string
    pip_name                      = string
    subnet_name                   = string
    virtual_network_name          = string

  }))

}
variable "linux_vm" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    size                = string
    # admin_username                  = string
    # admin_password                  = string
    disable_password_authentication = bool
    name_nic                        = string
    kv_name                         = string
    username_name                   = string
    password_name                   = string

  }))

}

variable "nsg" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    location             = string
    virtual_network_name = string
    subnet_name          = string
    name_nic             = string

  }))

}
variable "kayv" {
  type = map(object({
    name                       = string
    location                   = string
    resource_group_name        = string
    soft_delete_retention_days = number
    sku_name                   = string
  }))

}
variable "bastion" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    location             = string
    pip_name             = string
    subnet_name          = string
    virtual_network_name = string

  }))

}

variable "mssqlserver" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    minimum_tls_version = number
    kv_name             = string
    username_name       = string
    password_name       = string
  }))

}
variable "mssqldatabase" {
  type = map(object({
    name                = string
    server_name         = string
    resource_group_name = string
  }))

}
variable "acr" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku                 = string
    admin_enabled       = bool

  }))

}
variable "aks" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    node_pool_name      = string
    node_count          = number
    vm_size             = string
    network_plugin      = string

  }))
}