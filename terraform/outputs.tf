output "shared_resource_group_name" {
  description = "Shared resource group for identity, DNS, and monitoring."
  value       = azurerm_resource_group.shared.name
}

output "primary_vnet_id" {
  description = "Primary (hub) virtual network ID."
  value       = module.networking_primary.vnet_id
}

output "secondary_vnet_id" {
  description = "Secondary virtual network ID."
  value       = module.networking_secondary.vnet_id
}

output "vpn_gateway_id" {
  description = "Site-to-site virtual network gateway ID."
  value       = module.hybrid_vpn.gateway_id
}

output "log_analytics_workspace_id" {
  description = "Central Log Analytics workspace ID."
  value       = module.monitoring.log_analytics_workspace_id
}

output "management_vm_private_ip" {
  description = "Private IP of the management VM (no public IP)."
  value       = module.compute.private_ip_address
}

output "private_dns_zone_name" {
  description = "Private DNS zone used for hybrid name resolution."
  value       = azurerm_private_dns_zone.internal.name
}

output "workload_identity_principal_id" {
  description = "Principal ID of the workload managed identity."
  value       = module.identity.workload_identity_principal_id
}
