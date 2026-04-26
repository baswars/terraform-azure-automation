variable "mssqldatabase" {
  type = map(object({
    name                = string
    server_name         = string
    resource_group_name = string
  }))

}