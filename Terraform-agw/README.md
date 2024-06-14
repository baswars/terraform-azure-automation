# Azure Infrastructure Deployment with Terraform

This repository contains Terraform scripts for deploying an Azure infrastructure setup consisting of an Application Gateway, Bastion Host, two Linux VMs, one Virtual Network (VNet), and four Subnets. The configuration also makes use of data blocks, modules, and variables defined in `*.tfvars` files.

## Components

- **Application Gateway**: A web traffic (OSI layer 7) load balancer.
- **Bastion Host**: Provides secure and seamless RDP and SSH connectivity to the VMs.
- **Linux VMs**: Two virtual machines running Linux.
- **VNet**: A single virtual network containing all subnets.
- **Subnets**: 
  - Two subnets for the VMs
  - One subnet for the Bastion Host
  - One subnet for the Application Gateway

## Terraform Structure

### Main Components

1. **Virtual Network and Subnets**:
    - A VNet is created with four subnets.
    - Subnets are specified for VMs, Bastion Host, and Application Gateway.

2. **Linux VMs**:
    - Two Linux VMs are created in the VM subnets.

3. **Application Gateway**:
    - Configured to manage and route traffic.

4. **Bastion Host**:
    - Deployed in its designated subnet for secure access to the VMs.

### Usage of Data Blocks

Data blocks are used to fetch information about already created resources that are managed outside of Terraform or provisioned by another Terraform configuration. For instance, to get the subnet ID to configure network interface cards (NICs) for the VMs.

### Modules

Modules are used to encapsulate and reuse Terraform configurations. This structure makes the code more modular and easier to manage.

### Variables

Variables are defined in `*.tfvars` files to provide flexible and reusable configurations.

## Prerequisites

- Terraform installed on your local machine.
- Azure CLI installed and configured.
- An Azure subscription.

## Getting Started

1. **Clone the Repository**:
    ```sh
    git clone <repository_url>
    cd <repository_directory>
    ```

2. **Initialize Terraform**:
    ```sh
    terraform init
    ```

3. **Review and Update Variables**:
    - Review the `variables.tf` and `*.tfvars` files to ensure they match your desired configuration.
    - For example, update the `network.tfvars` file to specify your VNet and subnet configurations.

4. **Plan the Deployment**:
    ```sh
    terraform plan -var-file="network.tfvars"
    ```

5. **Apply the Configuration**:
    ```sh
    terraform apply -var-file="network.tfvars"
    ```

6. **Verify Deployment**:
    - Verify that the resources have been created in the Azure portal.
    - Ensure the Application Gateway, Bastion Host, VMs, VNet, and subnets are all correctly configured.

Conclusion
This Terraform configuration provides a robust setup for deploying an Azure infrastructure with an Application Gateway, Bastion Host, Linux VMs, VNet, and Subnets. By using data blocks, modules, and variable files, the configuration is modular, reusable, and easy to manage.

Feel free to contribute to this repository by submitting pull requests or reporting issues