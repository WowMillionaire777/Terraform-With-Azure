# The storage account will be used to store the script for Custom Script extension

resource "azurerm_storage_account" "vmstore4577687" {
  name                     = "vmstore4577687"
  resource_group_name      = "app-grp"
  location                 = "North Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"  
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_storage_container" "scripts" {
  name                  = "scripts"
  storage_account_name  = "vmstore4577687"
  container_access_type = "blob"
  depends_on=[
    azurerm_storage_account.vmstore4577687
    ]
}

resource "azurerm_storage_blob" "powershellscript" {
  name                   = "Script.ps1"
  storage_account_name   = "vmstore4577687"
  storage_container_name = "scripts"
  type                   = "Block"
  source                 = "Script.ps1"
   depends_on=[azurerm_storage_container.scripts]
}

resource "azurerm_storage_blob" "sqlscript" {
  name                   = "01.sql"
  storage_account_name   = "vmstore4577687"
  storage_container_name = "scripts"
  type                   = "Block"
  source                 = "01.sql"
   depends_on=[azurerm_storage_container.scripts
   
   ]
}

resource "azurerm_virtual_machine_extension" "vmextension" {
  name                 = "dbvm-extension"
  virtual_machine_id   = azurerm_windows_virtual_machine.dbvm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  depends_on = [
    azurerm_storage_blob.powershellscript,
    azurerm_storage_blob.sqlscript
  ]
  settings = <<SETTINGS
    {
        "fileUris": ["https://${azurerm_storage_account.vmstore4577687.name}.blob.core.windows.net/scripts/Script.ps1"],
          "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file Script.ps1"     
    }
SETTINGS

}
