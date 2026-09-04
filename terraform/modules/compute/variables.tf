variable "name" {
  type        = string
  description = "Short name used as a prefix for the management virtual machine."
}

variable "location" {
  type        = string
  description = "Azure region for the virtual machine."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for compute resources."
}

variable "subnet_id" {
  type        = string
  description = "Management subnet ID. The NIC has no public IP."
}

variable "vm_size" {
  type        = string
  description = "Azure VM size."
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Local administrator username (SSH only)."
  default     = "hybztadmin"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key for the management VM."
}

variable "user_assigned_identity_id" {
  type        = string
  description = "User-assigned managed identity attached to the VM."
}

variable "data_collection_rule_id" {
  type        = string
  description = "Azure Monitor data collection rule associated with the VM."
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the VM. Empty string leaves zone unspecified."
  default     = ""
}

variable "os_disk_type" {
  type        = string
  description = "Managed OS disk SKU."
  default     = "StandardSSD_LRS"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to compute resources."
  default     = {}
}
