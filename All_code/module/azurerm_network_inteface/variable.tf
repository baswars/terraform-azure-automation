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