resource_group1 = {
  rg = {
    name     = "rg-qa"
    location = "Central India"

  }
}

storage_account = {
  st = {
    name                     = "storagacccountsachin"
    resource_group_name      = "rg-qa"
    location                 = "Central India"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    container_name           = "mycontainer"
    container_access_type    = "private"
  }
}

virtual_network1 = {
  vnet = {
    name                = "vnet-qa"
    location            = "Central India"
    resource_group_name = "rg-qa"
    address_space       = ["10.0.0.0/16"]


  }
}
subnet = {
  subnet1 = {
    name                 = "subnet-frontend-qa"
    resource_group_name  = "rg-qa"
    virtual_network_name = "vnet-qa"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-qa"
    virtual_network_name = "vnet-qa"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "subnet-backend-qa"
    resource_group_name  = "rg-qa"
    virtual_network_name = "vnet-qa"
    address_prefixes     = ["10.0.3.0/24"]
  }
}
pip = {
  pip1 = {
    name                = "pip-frontend-qa"
    location            = "Central India"
    resource_group_name = "rg-qa"
    allocation_method   = "Static"
    sku                 = "Standard"

  }
  pip2 = {
    name                = "pip-backend-qa"
    location            = "Central India"
    resource_group_name = "rg-qa"
    allocation_method   = "Static"
    sku                 = "Standard"

  }
}

nic = {
  nic1 = {
    name                          = "nic-frontend-qa"
    pip_name                      = "pip-frontend-qa"
    location                      = "Central India"
    resource_group_name           = "rg-qa"
    subnet_name                   = "subnet-frontend-qa"
    virtual_network_name          = "vnet-qa"
    private_ip_address_allocation = "Dynamic"
  }
  nic2 = {
    name                          = "nic-backend-qa"
    pip_name                      = "pip-backend-qa"
    location                      = "Central India"
    resource_group_name           = "rg-qa"
    subnet_name                   = "subnet-backend-qa"
    virtual_network_name          = "vnet-qa"
    private_ip_address_allocation = "Dynamic"
  }
}
linux_vm = {
  vm1 = {
    name                = "linux-vm-frontend-qa"
    location            = "Central India"
    resource_group_name = "rg-qa"
    size                = "Standard_B2as_v2"
    # admin_username                  = "adminuser"
    # admin_password                  = "Admin@123"
    disable_password_authentication = false
    name_nic                        = "nic-frontend-qa"
    kv_name                         = "kvterrasachinr"
    username_name                   = "username"
    password_name                   = "password"
  }
  vm2 = {
    name                = "linux-vm-backend-qa"
    location            = "Central India"
    resource_group_name = "rg-qa"
    size                = "Standard_B2as_v2"
    # admin_username                  = "adminuser"
    # admin_password                  = "Admin@123"
    disable_password_authentication = false
    name_nic                        = "nic-backend-qa"
    kv_name                         = "kvterrasachinr"
    username_name                   = "username"
    password_name                   = "password"
  }
}
nsg = {
  nsg1 = {
    name                 = "nsg-frontend-qa"
    location             = "Central India"
    resource_group_name  = "rg-qa"
    name_nic             = "nic-frontend-qa"
    subnet_name          = "subnet-frontend-qa"
    virtual_network_name = "vnet-qa"
  }
  nsg2 = {
    name                 = "nsg-backend-qa"
    location             = "Central India"
    resource_group_name  = "rg-qa"
    name_nic             = "nic-backend-qa"
    subnet_name          = "subnet-backend-qa"
    virtual_network_name = "vnet-qa"
  }
}
kayv = {
  kv = {
    name                       = "kvterrasachinr"
    location                   = "Central India"
    resource_group_name        = "rg-qa"
    sku_name                   = "premium"
    soft_delete_retention_days = "7"
  }
}
bastion = {
  bas = {
    name                 = "bastion-qa"
    location             = "Central India"
    resource_group_name  = "rg-qa"
    virtual_network_name = "vnet-qa"
    subnet_name          = "AzureBastionSubnet"
    pip_name             = "pip-qa"
  }
}
mssqlserver = {
  server = {
    name                = "sqlserver2662"
    resource_group_name = "rg-qa"
    location            = "Central India"
    minimum_tls_version = "1.2"
    kv_name             = "kvterrasachinr"
    username_name       = "username"
    password_name       = "password"
  }

}
mssqldatabase = {
  db = {
    name                = "qa-db"
    resource_group_name = "rg-qa"
    server_name         = "sqlserver2662"
  }
}

acr = {
  acr = {
    name                = "qaacr"
    resource_group_name = "rg-qa"
    location            = "Central India"
    sku                 = "Premium"
    admin_enabled       = false
  }
}
aks = {
  aks1 = {
    name                = "aks-qa"
    resource_group_name = "rg-qa"
    location            = "Central India"
    dns_prefix          = "aks"
    node_pool_name      = "default"
    node_count          = 1
    vm_size             = "Standard_B2as_v2"
    network_plugin      = "azure"
  }
}