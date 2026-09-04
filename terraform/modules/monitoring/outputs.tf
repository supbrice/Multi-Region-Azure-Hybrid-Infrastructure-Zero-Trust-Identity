output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.name
}

output "data_collection_rule_id" {
  description = "ID of the Linux data collection rule used by the Azure Monitor Agent."
  value       = azurerm_monitor_data_collection_rule.linux.id
}

output "action_group_id" {
  description = "ID of the operations action group."
  value       = azurerm_monitor_action_group.ops.id
}
