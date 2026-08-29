resource "azurerm_user_assigned_identity" "workload" {
  name                = "${var.name_prefix}-id-workload"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_role_definition" "hybrid_network_operator" {
  name        = "${var.name_prefix}-hybrid-network-operator"
  scope       = var.assignable_scopes[0]
  description = "Read-focused hybrid network operations role. Intentionally narrower than Network Contributor."

  permissions {
    actions = [
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworkGateways/read",
      "Microsoft.Network/connections/read",
      "Microsoft.Network/localNetworkGateways/read",
      "Microsoft.Network/networkSecurityGroups/read",
      "Microsoft.Network/publicIPAddresses/read",
      "Microsoft.Network/bastionHosts/read",
      "Microsoft.Insights/diagnosticSettings/read",
      "Microsoft.Insights/metrics/read",
    ]
    not_actions = []
  }

  assignable_scopes = var.assignable_scopes
}

resource "azurerm_role_assignment" "operations_network_reader" {
  count = var.operations_group_object_id == "" ? 0 : length(var.assignable_scopes)

  scope              = var.assignable_scopes[count.index]
  role_definition_id = azurerm_role_definition.hybrid_network_operator.role_definition_resource_id
  principal_id       = var.operations_group_object_id
}

resource "azurerm_role_assignment" "security_readers" {
  count = var.security_readers_group_object_id == "" ? 0 : length(var.assignable_scopes)

  scope                = var.assignable_scopes[count.index]
  role_definition_name = "Reader"
  principal_id         = var.security_readers_group_object_id
}

resource "azuread_group" "platform_ops" {
  count = var.create_entra_groups ? 1 : 0

  display_name     = "${var.name_prefix}-${var.environment}-platform-ops"
  security_enabled = true
  description      = "Placeholder operations group for RBAC assignments. Created only when create_entra_groups is true."
}

resource "azuread_group" "security_readers" {
  count = var.create_entra_groups ? 1 : 0

  display_name     = "${var.name_prefix}-${var.environment}-security-readers"
  security_enabled = true
  description      = "Placeholder read-only group for audit access. Created only when create_entra_groups is true."
}
