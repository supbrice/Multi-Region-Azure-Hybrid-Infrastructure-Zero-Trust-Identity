output "vm_id" {
  description = "Resource ID of the management virtual machine."
  value       = azurerm_linux_virtual_machine.mgmt.id
}

output "vm_name" {
  description = "Name of the management virtual machine."
  value       = azurerm_linux_virtual_machine.mgmt.name
}

output "private_ip_address" {
  description = "Private IP of the management NIC. There is no public IP."
  value       = azurerm_network_interface.mgmt.ip_configuration[0].private_ip_address
}

output "network_interface_id" {
  description = "ID of the management network interface."
  value       = azurerm_network_interface.mgmt.id
}
