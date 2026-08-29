output "gateway_id" {
  description = "ID of the Azure virtual network gateway."
  value       = azurerm_virtual_network_gateway.this.id
}

output "gateway_name" {
  description = "Name of the Azure virtual network gateway."
  value       = azurerm_virtual_network_gateway.this.name
}

output "public_ip_id" {
  description = "Public IP used by the VPN gateway."
  value       = azurerm_public_ip.vpn.id
}

output "local_network_gateway_id" {
  description = "ID of the on-premises local network gateway placeholder."
  value       = azurerm_local_network_gateway.onprem.id
}

output "connection_id" {
  description = "ID of the site-to-site IPsec connection."
  value       = azurerm_virtual_network_gateway_connection.s2s.id
}
