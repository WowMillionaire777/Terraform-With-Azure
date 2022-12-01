/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_availability_set - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set

*/

resource "azurerm_availability_set" "appset" {
  name                = "app-set"
  location            = local.location
  resource_group_name = local.resource_group_name
  platform_fault_domain_count = 3
  platform_update_domain_count = 3

  depends_on = [
  azurerm_resource_group.appgrp  
  ]  
}