output "resource_group_name" {
  description = "Name of the regional network resource group."
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "ID of the regional network resource group."
  value       = azurerm_resource_group.this.id
}

output "vnet_id" {
  description = "ID of the regional virtual network."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the regional virtual network."
  value       = azurerm_virtual_network.this.name
}

output "gateway_subnet_id" {
  description = "ID of GatewaySubnet (required by the VPN gateway module)."
  value       = azurerm_subnet.gateway.id
}

output "mgmt_subnet_id" {
  description = "ID of the management subnet."
  value       = azurerm_subnet.mgmt.id
}

output "app_subnet_id" {
  description = "ID of the application subnet."
  value       = azurerm_subnet.app.id
}

output "data_subnet_id" {
  description = "ID of the data subnet."
  value       = azurerm_subnet.data.id
}

output "nsg_ids" {
  description = "Network security group IDs used for diagnostic settings."
  value = {
    mgmt = azurerm_network_security_group.mgmt.id
    app  = azurerm_network_security_group.app.id
    data = azurerm_network_security_group.data.id
  }
}

output "bastion_id" {
  description = "Azure Bastion host ID when Bastion is enabled."
  value       = var.enable_bastion ? azurerm_bastion_host.this[0].id : null
}
