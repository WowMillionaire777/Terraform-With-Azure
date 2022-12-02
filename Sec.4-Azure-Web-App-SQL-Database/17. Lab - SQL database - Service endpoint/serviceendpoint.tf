/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_mssql_virtual_network_rule - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_network_rule

*/

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = "new-grp"
  virtual_network_name = "new-grp-vnet"
  address_prefixes     = ["10.0.0.0/24"]
  service_endpoints = ["Microsoft.Sql"]
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_mssql_virtual_network_rule" "virtualnetworkrule" {
  name      = "sql-vnet-rule"
  server_id = azurerm_mssql_server.sqlserver.id
  subnet_id = azurerm_subnet.default.id
}