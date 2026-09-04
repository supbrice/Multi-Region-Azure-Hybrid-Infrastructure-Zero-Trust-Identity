output "workload_identity_id" {
  description = "Resource ID of the user-assigned managed identity for workloads."
  value       = azurerm_user_assigned_identity.workload.id
}

output "workload_identity_principal_id" {
  description = "Principal ID of the workload managed identity (used for RBAC)."
  value       = azurerm_user_assigned_identity.workload.principal_id
}

output "workload_identity_client_id" {
  description = "Client ID of the workload managed identity."
  value       = azurerm_user_assigned_identity.workload.client_id
}

output "custom_role_id" {
  description = "Resource ID of the custom hybrid network operator role."
  value       = azurerm_role_definition.hybrid_network_operator.role_definition_resource_id
}

output "platform_ops_group_object_id" {
  description = "Object ID of the optional Entra ID operations group."
  value       = var.create_entra_groups ? azuread_group.platform_ops[0].object_id : null
}
