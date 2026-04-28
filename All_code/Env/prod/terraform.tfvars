resource_group1 = {
  rg = {
    name     = "rg-prod"
    location = "Central India"

  }
}

storage_account = {
  st = {
    name                     = "storagacccountsachin"
    resource_group_name      = "rg-prod"
    location                 = "Central India"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    container_name           = "mycontainer"
    container_access_type    = "private"
  }
}

virtual_network1 = {
  vnet = {
    name                = "vnet-prod"
    location            = "Central India"
    resource_group_name = "rg-prod"
    address_space       = ["10.0.0.0/16"]


  }
}
subnet = {
  subnet1 = {
    name                 = "subnet-frontend-prod"
    resource_group_name  = "rg-prod"
    virtual_network_name = "vnet-prod"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-prod"
    virtual_network_name = "vnet-prod"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "subnet-backend-prod"
    resource_group_name  = "rg-prod"
    virtual_network_name = "vnet-prod"
    address_prefixes     = ["10.0.3.0/24"]
  }
}
pip = {
  pip1 = {
    name                = "pip-frontend-prod"
    location            = "Central India"
    resource_group_name = "rg-prod"
    allocation_method   = "Static"
    sku                 = "Standard"

  }
  pip2 = {
    name                = "pip-backend-prod"
    location            = "Central India"
    resource_group_name = "rg-prod"
    allocation_method   = "Static"
    sku                 = "Standard"

  }
}

nic = {
  nic1 = {
    name                          = "nic-frontend-prod"
    pip_name                      = "pip-frontend-prod"
    location                      = "Central India"
    resource_group_name           = "rg-prod"
    subnet_name                   = "subnet-frontend-prod"
    virtual_network_name          = "vnet-prod"
    private_ip_address_allocation = "Dynamic"
  }
  nic2 = {
    name                          = "nic-backend-prod"
    pip_name                      = "pip-backend-prod"
    location                      = "Central India"
    resource_group_name           = "rg-prod"
    subnet_name                   = "subnet-backend-prod"
    virtual_network_name          = "vnet-prod"
    private_ip_address_allocation = "Dynamic"
  }
}
linux_vm = {
  vm1 = {
    name                = "linux-vm-frontend-prod"
    location            = "Central India"
    resource_group_name = "rg-prod"
    size                = "Standard_B2as_v2"
    # admin_username                  = "adminuser"
    # admin_password                  = "Admin@123"
    disable_password_authentication = false
    name_nic                        = "nic-frontend-prod"
    kv_name                         = "kvterrasachinprod"
    username_name                   = "username"
    password_name                   = "password"
  }
  vm2 = {
    name                = "linux-vm-backend-prod"
    location            = "Central India"
    resource_group_name = "rg-prod"
    size                = "Standard_B2as_v2"
    # admin_username                  = "adminuser"
    # admin_password                  = "Admin@123"
    disable_password_authentication = false
    name_nic                        = "nic-backend-prod"
    kv_name                         = "kvterrasachinprod"
    username_name                   = "username"
    password_name                   = "password"
  }
}
nsg = {
  nsg1 = {
    name                 = "nsg-frontend-prod"
    location             = "Central India"
    resource_group_name  = "rg-prod"
    name_nic             = "nic-frontend-prod"
    subnet_name          = "subnet-frontend-prod"
    virtual_network_name = "vnet-prod"
  }
  nsg2 = {
    name                 = "nsg-backend-prod"
    location             = "Central India"
    resource_group_name  = "rg-prod"
    name_nic             = "nic-backend-prod"
    subnet_name          = "subnet-backend-prod"
    virtual_network_name = "vnet-prod"
  }
}
kayv = {
  kv = {
    name                       = "kvterrasachinprod"
    location                   = "Central India"
    resource_group_name        = "rg-prod"
    sku_name                   = "premium"
    soft_delete_retention_days = "7"
  }
}
bastion = {
  bas = {
    name                 = "bastion-prod"
    location             = "Central India"
    resource_group_name  = "rg-prod"
    virtual_network_name = "vnet-prod"
    subnet_name          = "AzureBastionSubnet"
    pip_name             = "pip-prod"
  }
}
mssqlserver = {
  server = {
    name                = "sqlserver2662"
    resource_group_name = "rg-prod"
    location            = "Central India"
    minimum_tls_version = "1.2"
    kv_name             = "kvterrasachinprod"
    username_name       = "username"
    password_name       = "password"
  }

}
mssqldatabase = {
  db = {
    name                = "prod-db"
    resource_group_name = "rg-prod"
    server_name         = "sqlserver2662"
  }
}

acr = {
  acr = {
    name                = "prod-acr"
    resource_group_name = "rg-prod"
    location            = "Central India"
    sku                 = "Premium"
    admin_enabled       = false
  }
}
aks = {
  aks1 = {
    name                = "aks-prod"
    resource_group_name = "rg-prod"
    location            = "Central India"
    dns_prefix          = "aks"
    node_pool_name      = "default"
    node_count          = 1
    vm_size             = "Standard_B2as_v2"
    network_plugin      = "azure"
  }
}