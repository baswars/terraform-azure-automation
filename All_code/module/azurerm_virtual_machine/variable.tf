variable "linux_vm" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    size                            = string
    # admin_username                  = string
    # admin_password                  = string
    disable_password_authentication = bool
    name_nic                        = string
    kv_name                         = string
    username_name                   = string
    password_name                   = string

  }))
}