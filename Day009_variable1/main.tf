# What is a Variable in Terraform?
# A variable in Terraform is a named value that can be used to parameterize your Terraform configuration. Variables allow you to define values that can be easily changed without modifying the actual code of your Terraform configuration. 
# This makes your configuration more flexible and reusable. advanges of using variables in Terraform include:
# 1. Reusability: Variables allow you to reuse the same configuration with different values, making it easier to manage and maintain your infrastructure.
# 2. Flexibility: Variables enable you to change the behavior of your Terraform configuration without modifying the code itself, which can help prevent errors and improve the overall maintainability of your infrastructure.
# 3. Separation of Concerns: Variables help to separate the configuration logic from the actual values, making it easier to understand and manage your infrastructure as code.
# 4. Collaboration: Variables allow multiple team members to work on the same Terraform configuration without conflicts, as they can define their own variable values without affecting others.
# 5. Environment-specific Configurations: Variables can be used to define different values for different environments (e.g., development, staging, production), allowing you to easily switch between environments without changing the underlying code.  
# In Terraform, you can define variables in a separate file (e.g., variables.tf) and then provide their values in another file (e.g., terraform.tfvars) or through command-line arguments when running Terraform commands. This separation of variable definitions and values helps to keep your configuration organized and maintainable.
# A variable lets you keep values dynamic rather than fixed.  

## What Problem Does It Solve?
# Problem without variables (Hardcoding)
# You must edit code for every environment (dev, QA, prod)
# Code is not reusable
# Higher chance of manual errors
# Not suitable for CI/CD automation
# Solution with variables (Dynamic Configuration)
# Define once, use everywhere
# Easily switch between environments
# Reusable and maintainable code
# Reduced risk of manual errors 

### Variables separate configuration (logic) from values (inputs)

## Main Types of Variables
# 1. String: sequence of characters enclosed in quotes (e.g., "rg-vm", "West Europe"). Strings can be used to represent text, such as names, descriptions, or any other textual data.
# 2. Number: numeric value that can be an integer or a floating-point number (e.g., 1, 3.14). Numbers are used for values that require mathematical operations or comparisons, such as counts, sizes, or thresholds.
# 3. Boolean: true or false value (e.g., true, false). Booleans are used for values that represent a binary state, such as enabling or disabling a feature, or indicating whether a condition is met.
# 4. List: ordered collection of values (e.g., ["dev", "qa", "prod"])
# 5. Map: unordered collection of key-value pairs (e.g., {dev = "East US", qa = "West Europe"})
# 6. Object: structured data type with named attributes (e.g., {name = "rg-vm", location = "East US"})
# 7. Tuple: ordered, immutable collection of values (e.g., ["dev", "qa", "prod"])

## Variable Lifecycle
# Variable Declaration: Define variables in your Terraform configuration.
# Variable Assignment: Assign values to variables.
# Variable Value Usage: Use variables in your resources and modules.

  # 1) Using CLI with -var: Use -var in terraform plan and terraform apply commands. Example: terraform plan -var="resource_group_name=myResourceGroup"

   # PS C:\Users\Sachin Baswar\Desktop\Terraform\terraform-azure-automation\Day009_variable1> terraform plan -var="resource_group_name=rgv1" 
   # Acquiring state lock. This may take a few moments...

   # Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
   # + create

   # Terraform will perform the following actions:

#   # azurerm_resource_group.rg will be created
#   + resource "azurerm_resource_group" "rg" {
#       + id       = (known after apply)
#       + location = "westeurope"
#       + name     = "rg-vm"
#     }

# Plan: 1 to add, 0 to change, 0 to destroy.
  # 2) Using Default in Variable Block: Set default values for variables in the variable block. Example:

variable "rg_name" {
  description = "name of resource group"
  type = string 
  default = "rg-vm" # sets a default value of "rg-vm" for the variable. If no value is provided for this variable when running Terraform commands, it will use "rg-vm" as the default value. This allows you to have a fallback value and makes it easier to manage your configuration without needing to specify a value every time. 
}
variable "location" {
  description = "location of resource group"
  type = string 
  default = "West Europe"
}
 # Using .tfvars Files: Create .tfvars files and pass them using -var-file in terraform plan and terraform apply commands. Example: terraform plan -var-file="myvars.tfvars"

 # using terraform.tfvars file: Create a terraform.tfvars file in the same directory as your Terraform configuration and define variable values in it. Terraform automatically loads this file when you run terraform plan or terraform apply, so you don't need to specify it with -var-file.
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}