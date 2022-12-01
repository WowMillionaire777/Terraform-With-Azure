terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.32.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "39be4fe7-7134-4527-ab9e-ef1e302f2d9d"
  tenant_id       = "e4fa2e28-d8ff-4dde-a7c9-fe565d955f6e"
  client_id       = "49bcca00-0071-4fb9-b9ad-9f3cd4f31224"
  client_secret   = "J~w8Q~ILCtnlgIvwVj5f59lZhNd8gRmJ37Up7cVI"
  features {}
}

resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = "East US"
}

resource "azurerm_storage_account" "appstore5674857" {
  name                     = "appstore5674857"
  resource_group_name      = "app-grp"
  location                 = "East US"
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  depends_on = [
    azurerm_resource_group.appgrp
  ]

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = "appstore5674857"
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.appstore5674857
  ]
}

resource "azurerm_storage_blob" "maintf" {
  name                   = "main.tf"
  storage_account_name   = "appstore5674857"
  storage_container_name = "data"
  type                   = "Block"
  source                 = "main.tf"
  depends_on = [
    azurerm_storage_container.data
  ]
}
