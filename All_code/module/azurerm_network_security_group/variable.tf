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