Local Block:

In Terraform, a locals block is used to define internal reusable values within the Terraform configuration.

These values are not provided by the user like variables; instead, they are defined inside the code to simplify expressions and avoid repetition.

For example, if I have a common value like location or naming convention used across multiple resources, instead of hardcoding it everywhere, I define it once in the locals block and reuse it using local.<name>.

This improves:

Code readability
Maintainability
Reduces duplication

In my projects, I use locals for things like:

Common resource names
Location
Tags
Naming standards