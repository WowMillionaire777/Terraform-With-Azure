/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_mssql_server - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server

2. azurerm_mssql_database - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database

*/

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sqlserver400908"
  resource_group_name          = local.resource_group_name
  location                     = local.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Azure@3456"  
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_mssql_database" "appdb" {
  name           = "appdb"
  server_id      = azurerm_mssql_server.sqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2  
  sku_name       = "Basic"  
  depends_on = [
    azurerm_mssql_server.sqlserver
      ]
  
}