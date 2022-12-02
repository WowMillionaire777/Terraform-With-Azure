resource "azurerm_service_plan" "companyplan" {
  name                = "companyplan"
  resource_group_name = local.resource_group_name
  location            = local.location
  os_type             = "Windows"
  sku_name            = "B1"
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_windows_web_app" "companyapp1000" {
  name                = "companyapp1000"
  resource_group_name = local.resource_group_name
  location            = local.location
  service_plan_id     = azurerm_service_plan.companyplan.id

  site_config {    
    application_stack {
    current_stack="dotnet"
    dotnet_version="v6.0"
}
  }

  connection_string {
    name  = "SQLConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${azurerm_mssql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.appdb.name};User Id=${azurerm_mssql_server.sqlserver.administrator_login};Password='${azurerm_mssql_server.sqlserver.administrator_login_password}';"
  }

depends_on = [
    azurerm_service_plan.companyplan
  ]
}

resource "azurerm_app_service_source_control" "appservice_sourcecontrol" {
  app_id   = azurerm_windows_web_app.companyapp1000.id
  repo_url = "https://github.com/alashro/sqlapp"
  branch   = "master"
  use_manual_integration = true  
}

