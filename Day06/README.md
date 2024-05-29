Azure Virtual Machine Deployment with Terraform
This Terraform configuration deploys a basic virtual machine (VM) on Microsoft Azure.

Resources:

Resource Group: rg-vm
Virtual Network: vnet-vm with subnet subnet-vm
Public IP: pip-vm
Network Interface: nic-vm with a security group association
Network Security Group: nsg-vm with allowing rules for all traffic (for demonstration purposes only)
Linux Virtual Machine: linux-vm with username adminuser and password Test@2020 (not recommended for production use)
Please note:

Security rules in the Network Security Group currently allow all inbound traffic. This should be adjusted for production use.
The password for the VM is stored in plain text. Consider using a secure key management solution for production environments.
For more information on specific resources, refer to the official Azure Terraform provider documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs.