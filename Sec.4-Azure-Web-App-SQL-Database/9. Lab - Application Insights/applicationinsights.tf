
/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_log_analytics_workspace - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace

2. azurerm_web_app_active_slot - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights

*/

resource "azurerm_log_analytics_workspace" "appworkspace" {
  name                = "appworkspace80089"
  location            = local.location
  resource_group_name = local.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appinsights" {
  name                = "appinsights203090"
  location            = local.location
  resource_group_name = local.resource_group_name
  application_type    = "web"
  workspace_id = azurerm_log_analytics_workspace.appworkspace.id
  depends_on = [
    azurerm_log_analytics_workspace.appworkspace
  ]
}