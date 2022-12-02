
/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_windows_web_app_slot - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app_slot

2. azurerm_web_app_active_slot - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_app_active_slot

*/

resource "azurerm_windows_web_app_slot" "staging" {
  name           = "staging"
  app_service_id = azurerm_windows_web_app.companyapp1000.id

  site_config {
    application_stack {
      current_stack="dotnet"
      dotnet_version="v6.0"
    }
  }

  depends_on = [
    azurerm_service_plan.companyplan
  ]
}

resource "azurerm_web_app_active_slot" "staging" {
  slot_id = azurerm_windows_web_app_slot.staging.id

}