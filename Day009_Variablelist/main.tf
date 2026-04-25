## List ###
# A list is an ordered collection of values. 
# Lists are defined using square brackets [] and can contain any type of values, including strings, numbers, booleans, or even other lists. 
# All values are usually of the same type (commonly strings)
# Example: ["dev", "qa", "prod"]
## Declare a List Variable
variable "rg_name" {
  type    = list(string)                   # Each value is a string
  default = ["rg-dev", "rg-qa", "rg-prod"] # rg_names contains multiple values

}
variable "location" {
  type    = list(string)                          # Each value is a string
  default = ["East US", "West US", "South India"] # location contains multiple values       
}

# resource "azurerm_resource_group" "rg" {  
#   name     = var.rg_name  
#   location = var.location 

# }

# │ Error: Incorrect attribute value type
# │ 
# │   on main.tf line 18, in resource "azurerm_resource_group" "rg":
# │   18:   name     = var.rg_name  
# │     ├────────────────
# │     │ var.rg_name is a list of string
# │ 
# │ Inappropriate value for attribute "name": string required, but have list of string.
# ╵
# ╷
# │ Error: Incorrect attribute value type
# │ 
# │   on main.tf line 19, in resource "azurerm_resource_group" "rg":
# │   19:   location = var.location 
# │     ├────────────────
# │     │ var.location is a list of string
# │ 
# │ Inappropriate value for attribute "location": string required, but have list of string.
# The Terraform plan output shows errors in main.tf at lines 18 and 19, where var.rg_name and var.location are defined as lists of strings, but the azurerm_resource_group resource requires string values for name and location.

# Correct Ways to Fix
# # 1) Use Indexing: Access specific elements of the list using their index. Example: var.rg_name[0] for the first resource group name and var.location[0] for the first location.
#  resource "azurerm_resource_group" "rg" {  
#    name     = var.rg_name[0]  
#    location = var.location[0]
   
#  }
#    # azurerm_resource_group.rg will be created
#   + resource "azurerm_resource_group" "rg" {
#       + id       = (known after apply)
#       + location = "eastus"
#       + name     = "rg-dev"
#     }
# 2) Option 2: Use count  to create multiple resources based on the list values. 
# resource "azurerm_resource_group" "rg" {  
#   count    = length(["rg-dev", "rg-qa", "rg-prod"]) # Create a resource for each name in the list
#   name     = var.rg_name[count.index]  # Access the current name using count.index
#   location = var.location[count.index]  # Access the corresponding location using count.index         
# }

# length() function is used to determine the number of elements in the list, which helps in creating the appropriate number of resources. The count.index is used to access the current index of the resource being created, allowing us to assign the correct name and location from the lists.
  # length(["rg-dev", "rg-qa", "rg-prod"]) = 3
# Releasing state lock. This may take a few moments...
# PS C:\Users\Sachin Baswar\Desktop\Terraform\terraform-azure-automation\Day009_Variable2> terraform plan
# Acquiring state lock. This may take a few moments...

# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated
# with the following symbols:
#   + create

# Terraform will perform the following actions:

# # azurerm_resource_group.rg[0] will be created
#   + resource "azurerm_resource_group" "rg" {
#       + id       = (known after apply)
#       + location = "eastus"
#       + name     = "rg-dev"
#     }

#   # azurerm_resource_group.rg[1] will be created
#   + resource "azurerm_resource_group" "rg" {
#       + id       = (known after apply)
#       + location = "westus"
#       + name     = "rg-qa"
#     }

#   # azurerm_resource_group.rg[2] will be created
#   + resource "azurerm_resource_group" "rg" {
#       + id       = (known after apply)
#       + location = "southindia"
#       + name     = "rg-prod"
#     }

# Plan: 3 to add, 0 to change, 0 to destroy.

#####Set#####
# A set is an unordered collection of unique values.    
# Because for_each does NOT accept list directly, we can use sets to create resources with for_each.
# Sets are defined using curly braces {} and can contain any type of values, including strings,

resource "azurerm_resource_group" "rg" {
    for_each = toset(var.rg_name)
    name = each.value
    location = "East US"
  
}

#PS C:\Users\Sachin Baswar\Desktop\Terraform\terraform-azure-automation\Day009_Variable2> terraform plan
# Acquiring state lock. This may take a few moments...

# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated
# with the following symbols:
#   + create

# Terraform will perform the following actions:

#   # azurerm_resource_group.rg["rg-dev"] will be created
#   + resource "azurerm_resource_group" "rg" {
#       + id       = (known after apply)
#       + location = "eastus"
#       + name     = "rg-dev"
#     }

#   # azurerm_resource_group.rg["rg-prod"] will be created
#   + resource "azurerm_resource_group" "rg" {
#       + id       = (known after apply)
#       + location = "eastus"
#       + name     = "rg-prod"
#     }

#   # azurerm_resource_group.rg["rg-qa"] will be created
#   + resource "azurerm_resource_group" "rg" {
#       + id       = (known after apply)
#       + location = "eastus"
#       + name     = "rg-qa"
#     }

# Plan: 3 to add, 0 to change, 0 to destroy.