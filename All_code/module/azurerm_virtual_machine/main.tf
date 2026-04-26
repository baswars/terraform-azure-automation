resource "azurerm_linux_virtual_machine" "vm-linux" {
  for_each                        = var.linux_vm
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = data.azurerm_key_vault_secret.username[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids = [
    data.azurerm_network_interface.nic[each.key].id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = base64encode(file("cloud-init.yaml"))
  # provisioner "remote-exec" { 
  #   inline = ["sudo apt-get update",
  #     "sudo apt-get install nginx -y"
  #   ]
  # }
  # connection {
  #   type     = "ssh"
  #   user     = data.azurerm_key_vault_secret.username[each.key].value
  #   password = data.azurerm_key_vault_secret.password[each.key].value
  #   # host     = self.public_ip_address
  #   host = self.
  # }


}
