variable "name_prefix" {
  type        = string
  description = "Prefix for identity resources (managed identity, custom role)."
}

variable "environment" {
  type        = string
  description = "Environment name (dev or prod)."
}

variable "location" {
  type        = string
  description = "Azure region for the user-assigned managed identity."
}

variable "resource_group_name" {
  type        = string
  description = "Shared resource group that owns the managed identity."
}

variable "assignable_scopes" {
  type        = list(string)
  description = "Resource IDs where the custom hybrid-network-operator role can be assigned."
}

variable "operations_group_object_id" {
  type        = string
  description = "Entra ID group object ID for day-to-day operators. Leave empty in the lab."
  default     = ""
}

variable "security_readers_group_object_id" {
  type        = string
  description = "Entra ID group object ID for audit/read access. Leave empty in the lab."
  default     = ""
}

variable "create_entra_groups" {
  type        = bool
  description = "Create placeholder Entra ID security groups. Off by default so a lab validate/plan does not mutate a tenant."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to Azure identity resources."
  default     = {}
}
