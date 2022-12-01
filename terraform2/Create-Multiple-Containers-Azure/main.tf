locals {
  resource_group_name = "app-grp"
  location            = "East US"
}

resource "azurerm_resource_group" "appgrp" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_storage_account" "appstore5674857" {
  name                     = "appstore5674857"
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_storage_container" "data" {
  count                 = 3
  name                  = "${count.index}data"
  storage_account_name  = "appstore5674857"
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.appstore5674857
  ]
}
