variable "name" {
  type        = string
  description = "Short name used as a prefix for regional network resources."
}

variable "location" {
  type        = string
  description = "Azure region for this virtual network."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group created for this region's network."
}

variable "address_space" {
  type        = list(string)
  description = "IPv4 address space for the virtual network."
}

variable "subnets" {
  type = object({
    gateway = string
    bastion = optional(string)
    mgmt    = string
    app     = string
    data    = string
  })
  description = "CIDR prefixes for required subnets. gateway must be named GatewaySubnet in Azure."
}

variable "on_premises_address_spaces" {
  type        = list(string)
  description = "On-premises CIDR ranges allowed into the management and application subnets over the hybrid tunnel."
}

variable "enable_bastion" {
  type        = bool
  description = "Create Azure Bastion (AzureBastionSubnet + public IP + bastion host)."
  default     = false
}

variable "bastion_sku" {
  type        = string
  description = "Azure Bastion SKU. Basic is enough for a lab jump path; Standard adds features used in larger estates."
  default     = "Basic"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Attach a NAT Gateway to mgmt, app, and data subnets so workloads have no public IPs."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources in this module."
  default     = {}
}
