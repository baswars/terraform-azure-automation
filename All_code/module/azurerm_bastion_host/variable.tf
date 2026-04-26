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