# Loop:
# Repeat resource creation or logic multiple times automatically

# 2. Types of Loops in Terraform
# Terraform mainly provides 3 looping mechanisms:
# 1) count
# 2) for_each
# 3) for expression (advanced)
# 1. count:
# Count is a meta-argument in Terraform used to create multiple instances of a resource. 
# It works in an index-based manner, where Terraform assigns a numeric index called count.index starting from 0. 
# We typically use it with lists, and the number of resources created depends on the value of count, such as count = length(var.list). 
# However, since it is index-based, any change in the order of the list can lead to resource recreation, 
# so it’s less stable compared to for_each.

# resource "azurerm_resource_group" "rg" {
#   count    = 3
#   name     = "rg-vm-${count.index}"
#   location = "south India"

# }

variable "rg_name" {
  type    = list(string)
  default = ["rg-vm", "rg-vm-2", "rg-vm-3", "rg-vm-4", "rg-vm-5"]
  
}
resource "azurerm_resource_group" "rg" {
  count = length(var.rg_name  )
  name     = var.rg_name[count.index]
  location = "south India"

}
