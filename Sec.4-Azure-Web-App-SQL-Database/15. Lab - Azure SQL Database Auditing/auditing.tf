
/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_mssql_database_extended_auditing_policy - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database_extended_auditing_policy

2. azurerm_monitor_diagnostic_setting - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting

*/


resource "azurerm_log_analytics_workspace" "dbworkspace" {
  name                = "dbworkspace80089"
  location            = local.location
  resource_group_name = local.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_mssql_database_extended_auditing_policy" "sqlauditing" {
  database_id                             = azurerm_mssql_database.appdb.id
  log_monitoring_enabled = true  
  depends_on = [
    azurerm_mssql_database.appdb
  ]  
}

resource "azurerm_monitor_diagnostic_setting" "diagnosticsetting" {
  name               = "${azurerm_mssql_database.appdb.name}-setting"
  target_resource_id = "${azurerm_mssql_database.appdb.id}"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.dbworkspace.id
  log {
    category = "SQLSecurityAuditEvents"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  depends_on = [
    azurerm_log_analytics_workspace.dbworkspace,
    azurerm_mssql_database.appdb
  ]
}