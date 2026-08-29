variable "name" {
  type        = string
  description = "Short name used as a prefix for VPN gateway resources."
}

variable "location" {
  type        = string
  description = "Azure region for the virtual network gateway."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group that already contains GatewaySubnet."
}

variable "gateway_subnet_id" {
  type        = string
  description = "ID of the GatewaySubnet in the hub virtual network."
}

variable "sku" {
  type        = string
  description = "VPN gateway SKU (VpnGw1 for lab/dev, VpnGw2 for a larger production-shaped lab)."
  default     = "VpnGw1"
}

variable "generation" {
  type        = string
  description = "Virtual network gateway generation."
  default     = "Generation1"
}

variable "on_premises_gateway_name" {
  type        = string
  description = "Name of the local network gateway that represents the on-premises VPN device."
  default     = "onprem-lng"
}

variable "on_premises_gateway_address" {
  type        = string
  description = "Public IPv4 address of the on-premises VPN peer. Use a documentation address in this lab."
}

variable "on_premises_address_spaces" {
  type        = list(string)
  description = "On-premises networks advertised through the site-to-site tunnel."
}

variable "shared_key" {
  type        = string
  description = "IPsec pre-shared key. Replace the lab default before any real deployment."
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to VPN resources."
  default     = {}
}
