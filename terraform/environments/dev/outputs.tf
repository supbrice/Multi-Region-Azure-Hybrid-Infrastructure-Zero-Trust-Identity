output "shared_resource_group_name" {
  value = module.stack.shared_resource_group_name
}

output "primary_vnet_id" {
  value = module.stack.primary_vnet_id
}

output "secondary_vnet_id" {
  value = module.stack.secondary_vnet_id
}

output "vpn_gateway_id" {
  value = module.stack.vpn_gateway_id
}

output "log_analytics_workspace_id" {
  value = module.stack.log_analytics_workspace_id
}

output "management_vm_private_ip" {
  value = module.stack.management_vm_private_ip
}

output "private_dns_zone_name" {
  value = module.stack.private_dns_zone_name
}
