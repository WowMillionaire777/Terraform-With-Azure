resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = "North Europe"
}

resource "azurerm_storage_account" "appstore566565637" {  
  name                     = "appstore566565637"
  resource_group_name      = "app-grp"
  location                 = "North Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_storage_container" "data" {
  for_each = toset(["data","files","documents"])
  name                  = each.key
  storage_account_name  = "appstore566565637"
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.appstore566565637
  ]
}

resource "azurerm_storage_blob" "files" {
  for_each = {
    sample1="C:\\tmp1\\sample1.txt"
    sample2="C:\\tmp2\\sample2.txt"
    sample3="C:\\tmp3\\sample3.txt"
  }
  name                   = each.key
  storage_account_name   = "appstore566565637"
  storage_container_name = "data"
  type                   = "Block"
  source                 = each.value
  depends_on = [
    azurerm_storage_account.appstore566565637
  ]
}