variable "rg" {
  description = "A map of resource groups to create."
  type = map(object({
    name     = string
    location = string
  }))

}
# We use object when we need to pass multiple attributes for a single resource instead of just one value.
# In this case, we have a resource group that has two attributes: name and location. 
# benifits of using object:
# 1. Structured data: It allows us to group related attributes together, making it easier to manage and understand the data.
# 2. Validation: We can define the expected structure of the data, which helps in catching errors early on. For example, if we expect a string for the name and a string for the location, we can enforce that in our code.
# 3. Reusability: We can reuse the same object structure for multiple resources, which promotes consistency and reduces code duplication. For example, if we have multiple resource groups with the same attributes, we can use the same object structure for all of them.     


variable "vnet" {
  description = "A map of virtual networks to create."
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
  }))
}
variable "subnet" {
  type = map(object({
    name                = string
    resource_group_name = string
    virtual_network     = string
    address_prefixes    = list(string)
  }))

}
variable "pip" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
  }))

}
variable "nic" {
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    private_ip_address_allocation = string
    ip_config_name                = string
    subnet                        = string
    pip                           = string
  }))

}
variable "linux_vm" {
  type = map(object({
    name                            = string
    resource_group                  = string
    location                        = string
    size                            = string
    admin_username                  = string
    admin_password                  = string
    disable_password_authentication = bool
    os_disk_caching                 = string
    os_disk_storage_account_type    = string
    source_image_publisher          = string
    source_image_offer              = string
    source_image_sku                = string
    source_image_version            = string
    nic                             = string
  }))

}