variable "kayv" {
  type = map(object({
    name                       = string
    location                   = string
    resource_group_name        = string
    soft_delete_retention_days = number
    sku_name                   = string
  }))

}