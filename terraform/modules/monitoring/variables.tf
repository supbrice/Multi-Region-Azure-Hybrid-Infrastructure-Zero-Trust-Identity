variable "name_prefix" {
  type        = string
  description = "Prefix for monitoring resources."
}

variable "location" {
  type        = string
  description = "Azure region for the Log Analytics workspace."
}

variable "resource_group_name" {
  type        = string
  description = "Shared resource group for monitoring."
}

variable "log_retention_days" {
  type        = number
  description = "Log Analytics retention in days."
  default     = 30
}

variable "alert_email" {
  type        = string
  description = "Email address for the operations action group. Use a mailbox you control before any real apply."
}

variable "diagnostic_targets" {
  type        = map(string)
  description = "Map of friendly name to Azure resource ID for diagnostic settings."
  default     = {}
}

variable "vpn_gateway_id" {
  type        = string
  description = "Virtual network gateway ID used for the tunnel metric alert. Empty string skips the alert."
  default     = ""
}

variable "workload_identity_principal_id" {
  type        = string
  description = "Principal ID that receives Log Analytics Reader on the workspace."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to monitoring resources."
  default     = {}
}
