resource "azurerm_storage_account" "datalakestore4577688" {
  name                     = "datalakestore4577688"
  resource_group_name      = "app-grp"
  location                 = "North Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"  
  is_hns_enabled = true
  depends_on = [
    azurerm_resource_group.appgrp
   ]
}

