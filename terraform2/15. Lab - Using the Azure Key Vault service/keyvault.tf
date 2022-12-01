/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_key_vault - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault

2. azurerm_key_vault_secret - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret

*/

data "azurerm_client_config" "current"{}

resource "azurerm_key_vault" "appvault" {
  name                        = "appvault7886867"
  location                    = local.location
  resource_group_name         = local.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get","Set"
    ]    
  }
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_key_vault_secret" "vmpassword" {
  name         = "vmpassword"
  value        = "Azure@123"
  key_vault_id = azurerm_key_vault.appvault.id
  depends_on = [
    azurerm_key_vault.appvault
  ]
}