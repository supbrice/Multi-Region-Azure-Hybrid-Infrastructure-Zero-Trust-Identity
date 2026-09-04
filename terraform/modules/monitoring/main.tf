resource "azurerm_log_analytics_workspace" "this" {
  name                = "${var.name_prefix}-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days
  tags                = var.tags
}

resource "azurerm_monitor_data_collection_rule" "linux" {
  name                = "${var.name_prefix}-dcr-linux"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  tags                = var.tags

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.this.id
      name                  = "law"
    }
  }

  data_flow {
    streams      = ["Microsoft-Syslog", "Microsoft-Perf"]
    destinations = ["law"]
  }

  data_sources {
    syslog {
      facility_names = ["auth", "authpriv", "daemon", "syslog"]
      log_levels     = ["Warning", "Error", "Critical", "Alert", "Emergency"]
      name           = "syslog"
      streams        = ["Microsoft-Syslog"]
    }

    performance_counter {
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60
      counter_specifiers = [
        "Processor(*)\\% Processor Time",
        "Memory(*)\\Available Bytes",
        "LogicalDisk(*)\\% Free Space",
      ]
      name = "perf"
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "targets" {
  for_each = var.diagnostic_targets

  name                       = "${var.name_prefix}-diag-${each.key}"
  target_resource_id         = each.value
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

resource "azurerm_monitor_action_group" "ops" {
  name                = "${var.name_prefix}-ag-ops"
  resource_group_name = var.resource_group_name
  short_name          = "hybztops"
  tags                = var.tags

  email_receiver {
    name                    = "operations"
    email_address           = var.alert_email
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_metric_alert" "vpn_bandwidth" {
  count = var.vpn_gateway_id == "" ? 0 : 1

  name                = "${var.name_prefix}-vpn-tunnel"
  resource_group_name = var.resource_group_name
  scopes              = [var.vpn_gateway_id]
  description         = "Site-to-site gateway average bandwidth dropped below the lab threshold."
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"
  tags                = var.tags

  criteria {
    metric_namespace = "Microsoft.Network/virtualNetworkGateways"
    metric_name      = "AverageBandwidth"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 1
  }

  action {
    action_group_id = azurerm_monitor_action_group.ops.id
  }
}

resource "azurerm_role_assignment" "workload_law_reader" {
  scope                = azurerm_log_analytics_workspace.this.id
  role_definition_name = "Log Analytics Reader"
  principal_id         = var.workload_identity_principal_id
}
