resource "azurerm_network_interface" "mgmt" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "mgmt" {
  name                            = "${var.name}-vm"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.mgmt.id]
  zone                            = var.availability_zone == "" ? null : var.availability_zone
  tags                            = var.tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.user_assigned_identity_id]
  }

  os_disk {
    name                 = "${var.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "azure_monitor_agent" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.mgmt.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.33"
  automatic_upgrade_enabled  = true
  auto_upgrade_minor_version = true
  tags                       = var.tags
}

resource "azurerm_monitor_data_collection_rule_association" "mgmt" {
  name                    = "${var.name}-dcra"
  target_resource_id      = azurerm_linux_virtual_machine.mgmt.id
  data_collection_rule_id = var.data_collection_rule_id

  depends_on = [azurerm_virtual_machine_extension.azure_monitor_agent]
}
