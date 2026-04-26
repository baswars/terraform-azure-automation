resource_group1 = {
  rg = {
    name     = "rg-dev"
    location = "Central India"

  }
}

storage_account = {
  st = {
    name                     = "storagacccountsachin"
    resource_group_name      = "rg-dev"
    location                 = "Central India"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    container_name           = "mycontainer"
    container_access_type    = "private"
  }
}

virtual_network1 = {
  vnet = {
    name                = "vnet-frontend"
    location            = "Central India"
    resource_group_name = "rg-dev"
    address_space       = ["10.0.0.0/16"]


  }
}
subnet = {
  subnet1 = {
    name                 = "subnet-frontend"
    resource_group_name  = "rg-dev"
    virtual_network_name = "vnet-frontend"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-dev"
    virtual_network_name = "vnet-frontend"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "subnet-backend"
    resource_group_name  = "rg-dev"
    virtual_network_name = "vnet-frontend"
    address_prefixes     = ["10.0.3.0/24"]
  }
}
pip = {
  pip1 = {
    name                = "pip-frontend"
    location            = "Central India"
    resource_group_name = "rg-dev"
    allocation_method   = "Static"
    sku                 = "Standard"

  }
  pip2 = {
    name                = "pip-backend"
    location            = "Central India"
    resource_group_name = "rg-dev"
    allocation_method   = "Static"
    sku                 = "Standard"

  }
}

nic = {
  nic1 = {
    name                          = "nic-frontend"
    pip_name                      = "pip-frontend"
    location                      = "Central India"
    resource_group_name           = "rg-dev"
    subnet_name                   = "subnet-frontend"
    virtual_network_name          = "vnet-frontend"
    private_ip_address_allocation = "Dynamic"
  }
  nic2 = {
    name                          = "nic-backend"
    pip_name                      = "pip-backend"
    location                      = "Central India"
    resource_group_name           = "rg-dev"
    subnet_name                   = "subnet-backend"
    virtual_network_name          = "vnet-frontend"
    private_ip_address_allocation = "Dynamic"
  }
}
linux_vm = {
  vm1 = {
    name                = "linux-vm-frontend"
    location            = "Central India"
    resource_group_name = "rg-dev"
    size                = "Standard_B2as_v2"
    # admin_username                  = "adminuser"
    # admin_password                  = "Admin@123"
    disable_password_authentication = false
    name_nic                        = "nic-frontend"
    kv_name                         = "kvterrasachinr"
    username_name                   = "username"
    password_name                   = "password"
  }
  vm2 = {
    name                = "linux-vm-backend"
    location            = "Central India"
    resource_group_name = "rg-dev"
    size                = "Standard_B2as_v2"
    # admin_username                  = "adminuser"
    # admin_password                  = "Admin@123"
    disable_password_authentication = false
    name_nic                        = "nic-backend"
    kv_name                         = "kvterrasachinr"
    username_name                   = "username"
    password_name                   = "password"
  }
}
nsg = {
  nsg1 = {
    name                 = "nsg-frontend"
    location             = "Central India"
    resource_group_name  = "rg-dev"
    name_nic             = "nic-frontend"
    subnet_name          = "subnet-frontend"
    virtual_network_name = "vnet-frontend"
  }
  nsg2 = {
    name                 = "nsg-backend"
    location             = "Central India"
    resource_group_name  = "rg-dev"
    name_nic             = "nic-backend"
    subnet_name          = "subnet-backend"
    virtual_network_name = "vnet-frontend"
  }
}
kayv = {
  kv = {
    name                       = "kvterrasachinr"
    location                   = "Central India"
    resource_group_name        = "rg-dev"
    sku_name                   = "premium"
    soft_delete_retention_days = "7"
  }
}
bastion = {
  bas = {
    name                 = "bastionmy"
    location             = "Central India"
    resource_group_name  = "rg-dev"
    virtual_network_name = "vnet-frontend"
    subnet_name          = "AzureBastionSubnet"
    pip_name             = "pip-frontend"
  }
}
mssqlserver = {
  server = {
    name                = "sqlserver2662"
    resource_group_name = "rg-dev"
    location            = "Central India"
    minimum_tls_version = "1.2"
    kv_name             = "kvterrasachinr"
    username_name       = "username"
    password_name       = "password"
  }

}
mssqldatabase = {
  db = {
    name                = "sachin-db"
    resource_group_name = "rg-dev"
    server_name         = "sqlserver2662"
  }
}

acr = {
  acr = {
    name                = "sachinacr"
    resource_group_name = "rg-dev"
    location            = "Central India"
    sku                 = "Premium"
    admin_enabled       = false
  }
}
aks = {
  aks1 = {
    name                = "aks"
    resource_group_name = "rg-dev"
    location            = "Central India"
    dns_prefix          = "aks"
    node_pool_name      = "default"
    node_count          = 1
    vm_size             = "Standard_B2as_v2"
    network_plugin      = "azure"
  }
}