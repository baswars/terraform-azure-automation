variable "mssqlserver" {
  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    minimum_tls_version          = number
    kv_name                      = string
    username_name           = string
    password_name = string
  }))

}