# Terraform stack

Environment roots live in `environments/dev` and `environments/prod`. This directory is a stack module those roots call.

| Module | Responsibility |
| --- | --- |
| `modules/networking` | Regional resource group, VNet, GatewaySubnet, optional AzureBastionSubnet, mgmt/app/data, NSGs, NAT Gateway, Bastion |
| `modules/hybrid-vpn` | Standard public IP, route-based VPN gateway, local network gateway, IKEv2 site-to-site connection |
| `modules/identity` | User-assigned identity, custom RBAC role, optional Entra groups and assignments |
| `modules/compute` | Linux management VM (no public IP), Azure Monitor Agent, data collection rule association |
| `modules/monitoring` | Log Analytics workspace, Linux DCR, diagnostic settings, action group, VPN metric alert |

Peering and the private DNS zone are defined in this stack (`main.tf`) because they join both regions.
