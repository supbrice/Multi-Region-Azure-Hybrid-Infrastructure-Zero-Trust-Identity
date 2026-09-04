variable "subscription_id" {
  type        = string
  description = "Target Azure subscription. Dummy value is fine for terraform validate."

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.subscription_id))
    error_message = "subscription_id must be a GUID."
  }
}

variable "environment" {
  type        = string
  description = "Environment name. Must be dev or prod."

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be dev or prod."
  }
}

variable "name_prefix" {
  type        = string
  description = "Short prefix for globally sensitive names (Log Analytics, etc.)."
  default     = "hybzt"
}

variable "primary_location" {
  type        = string
  description = "Primary Azure region (hub with the VPN gateway)."
  default     = "eastus2"
}

variable "secondary_location" {
  type        = string
  description = "Secondary Azure region (peered spoke/hub)."
  default     = "centralus"
}

variable "primary_address_space" {
  type        = list(string)
  description = "Address space for the primary virtual network."
}

variable "secondary_address_space" {
  type        = list(string)
  description = "Address space for the secondary virtual network."
}

variable "primary_subnets" {
  type = object({
    gateway = string
    bastion = optional(string)
    mgmt    = string
    app     = string
    data    = string
  })
  description = "Subnet prefixes for the primary region."
}

variable "secondary_subnets" {
  type = object({
    gateway = string
    bastion = optional(string)
    mgmt    = string
    app     = string
    data    = string
  })
  description = "Subnet prefixes for the secondary region."
}

variable "on_premises_address_spaces" {
  type        = list(string)
  description = "On-premises networks reached through the site-to-site tunnel."
}

variable "on_premises_gateway_address" {
  type        = string
  description = "Public IP of the on-premises VPN device. Documentation range is used in this lab."
}

variable "on_premises_dns_ip" {
  type        = string
  description = "Placeholder on-premises DNS resolver recorded in the private zone."
}

variable "private_dns_zone_name" {
  type        = string
  description = "Private DNS zone for hybrid name resolution."
  default     = "hybzt.internal"
}

variable "enable_bastion" {
  type        = bool
  description = "Deploy Azure Bastion in the primary region."
  default     = true
}

variable "bastion_sku" {
  type        = string
  description = "Azure Bastion SKU."
  default     = "Basic"
}

variable "vpn_sku" {
  type        = string
  description = "VPN gateway SKU."
  default     = "VpnGw1"
}

variable "vpn_generation" {
  type        = string
  description = "VPN gateway generation."
  default     = "Generation1"
}

variable "vpn_shared_key" {
  type        = string
  description = "IPsec pre-shared key. Lab default must be replaced before any real apply."
  sensitive   = true
}

variable "vm_size" {
  type        = string
  description = "Size of the primary management VM."
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "SSH username for the management VM."
  default     = "hybztadmin"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key for the management VM."
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the management VM. Empty means platform-assigned."
  default     = ""
}

variable "log_retention_days" {
  type        = number
  description = "Log Analytics retention in days."
  default     = 30
}

variable "alert_email" {
  type        = string
  description = "Operations mailbox for Azure Monitor action group emails."
}

variable "operations_group_object_id" {
  type        = string
  description = "Existing Entra ID group for operations RBAC. Empty in the lab."
  default     = ""
}

variable "security_readers_group_object_id" {
  type        = string
  description = "Existing Entra ID group for read-only audit RBAC. Empty in the lab."
  default     = ""
}

variable "create_entra_groups" {
  type        = bool
  description = "Create placeholder Entra ID groups. Leave false unless you intend to change a tenant."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Additional tags merged with the standard set."
  default     = {}
}
