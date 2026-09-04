variable "subscription_id" {
  type        = string
  description = "Azure subscription ID. Dummy GUID is enough for terraform validate."
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key for the management VM."
}

variable "vpn_shared_key" {
  type        = string
  description = "IPsec pre-shared key. Lab value only."
  sensitive   = true
}

variable "alert_email" {
  type        = string
  description = "Operations mailbox for Monitor alerts."
}

variable "operations_group_object_id" {
  type        = string
  description = "Optional Entra ID operations group object ID."
  default     = ""
}

variable "security_readers_group_object_id" {
  type        = string
  description = "Optional Entra ID security-readers group object ID."
  default     = ""
}
