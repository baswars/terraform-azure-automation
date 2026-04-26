# For_each
# for_each is a meta-argument used to create multiple instances of a resource using a set or map.
# key-based (not index-based)
# More stable and predictable
# reduce code duplication
# imrove code readability
# For_each with maps allows you to create resources with unique keys, making it easier to manage and reference them.
# Map is a collection of key-value pairs, where each key is unique and maps to a specific value. 
# In Terraform, you can use maps to define resources with unique identifiers, allowing for more flexible and dynamic resource creation. When using for_each with maps, you can reference the keys to create resources with specific attributes based on the values associated with those keys. This approach enhances code readability and maintainability by providing clear associations between resource instances and their corresponding configurations.
# for_each is used to create multiple resources using key-value pairs. It loops over a map, where each.key is used as name and each.value as configuration

# variable "rg" {

#   default = {
#     rg-vm = "East Us"
#     rg-db = "West Us"
#   }
# }

# resource "azurerm_resource_group" "rg" { # This block defines an Azure Resource Group resource. 
#   for_each = var.rg
#   name     = each.key
#   location = each.value

# }
# meaning: for each key-value pair in the var.rg map, create a resource group with the name as the key and location as the value. 

# For_each with maps of objects
# A map of objects is a collection of key-value pairs, where each key maps to an object containing multiple attributes. 
#This allows for more complex configurations when using for_each, as you can define multiple properties for each resource instance based on the values in the map. 
# When using a map of objects with for_each, you can reference specific attributes of each object to configure the resources accordingly, providing greater flexibility and organization in your Terraform code.  

# variable "example" {
#   default = {
#     key1 = {
#       attr1 = "value1"
#       attr2 = "value2"
#     }
#     key2 = {
#       attr1 = "value3"
#       attr2 = "value4"
#     }
#   }
# }

variable "rg" {
  default = { # This block defines a variable named "rg" with a default value of a map containing a single key-value pair. 
    rg-vm = {
      name     = "rg-vm"
      location = "West Europe"
    }
  }

}

resource "azurerm_resource_group" "rg" { # This block defines an Azure Resource Group resource. 
  for_each = var.rg
  name     = each.value.name # The name of the resource group is set to the "name" attribute of the value in the map for each key.
  location = each.value.location

}
# Map of objects is a data structure where each key maps to a complex object containing multiple attributes, commonly used with for_each to create dynamic resources."