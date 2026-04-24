In Terraform, a variable is used to parameterize the configuration, meaning we don’t hardcode values—we make them dynamic and reusable.

🔹 What is a Variable?

A variable is a placeholder for a value that can be defined once and used across the Terraform configuration.

For example, instead of writing "East US" everywhere, we define a variable and reuse it.

🔹 Why is it needed?

Variables are important because they:

Make code reusable across environments (dev, qa, prod)
Avoid hardcoding values
Improve maintainability and flexibility
Allow different inputs without changing code

🔹 Types of Variables

Terraform supports:

Primitive types → string, number, bool
Complex types → list, map, object, tuple, any

🔹 How to use Variables?
1️⃣ Define Variable
variable "location" {
  type    = string
  default = "East US"
}
2️⃣ Use Variable
resource "azurerm_resource_group" "rg" {
  name     = "rg-demo"
  location = var.location
}
3️⃣ Override Value (Optional)

Using .tfvars:

location = "Central India"

Or CLI:

terraform apply -var="location=West US"