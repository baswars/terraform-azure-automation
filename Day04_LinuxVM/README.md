🚀 Azure Infrastructure Deployment using Terraform
📌 Overview

This project uses Terraform to provision a complete Azure infrastructure, including networking and a Linux Virtual Machine.

The setup follows Infrastructure as Code (IaC) principles and uses a remote backend for centralized state management.

🏗️ Architecture Components

The following resources are created:

Resource Group
Virtual Network (VNet)
Subnet
Public IP
Network Interface (NIC)
Network Security Group (NSG) with SSH access
Linux Virtual Machine
🔧 Terraform Configuration
🔹 Backend Configuration
Uses Azure Storage Account to store Terraform state remotely
Ensures team collaboration and state consistency
backend "azurerm" {
  resource_group_name  = "rg-backend"
  storage_account_name = "storageaccobackend"
  container_name       = "storagecontainerbackend"
  key                  = "terraform.tfstate"
}
🔹 Provider
Azure Resource Manager (azurerm)
Version: 4.69.0
🌐 Networking Setup
VNet CIDR: 10.0.0.0/16
Subnet CIDR: 10.0.1.0/24
Public IP: Static allocation
NIC attached to subnet and public IP
🔐 Security (NSG Rules)
Allows SSH access on port 22
Currently open to all (*) ⚠️

🔒 Best Practice: Restrict source_address_prefix to your IP for better security.

🖥️ Virtual Machine Details
OS: Ubuntu 22.04 LTS
Size: Standard_F2
Authentication: Username & Password
Password authentication enabled
🔗 Resource Dependencies

Terraform automatically manages dependencies:

VNet depends on Resource Group
Subnet depends on VNet
NIC depends on Subnet & Public IP
VM depends on NIC
▶️ How to Use
1️⃣ Initialize Terraform
terraform init
2️⃣ Validate Configuration
terraform validate
3️⃣ Plan Deployment
terraform plan
4️⃣ Apply Changes
terraform apply