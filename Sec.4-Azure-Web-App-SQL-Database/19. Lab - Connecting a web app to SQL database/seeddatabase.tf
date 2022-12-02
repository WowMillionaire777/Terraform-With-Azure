resource "null_resource" "database_setup" {
  provisioner "local-exec" {
      command = "sqlcmd -S ${azurerm_mssql_server.sqlserver.fully_qualified_domain_name} -U ${azurerm_mssql_server.sqlserver.administrator_login} -P ${azurerm_mssql_server.sqlserver.administrator_login_password} -d appdb -i 01.sql"
  }
  depends_on=[
    azurerm_mssql_database.appdb
  ]
}