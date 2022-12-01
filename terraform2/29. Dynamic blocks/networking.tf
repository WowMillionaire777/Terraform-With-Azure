resource "azurerm_network_security_group" "appnsg" {
  name                = "app-nsg"
  location            = local.location 
  resource_group_name = local.resource_group_name


dynamic security_rule{
  for_each=local.networksecuritygroup_rules
  content {
    name="Allow-${security_rule.value.destination_port_range}"
    priority=security_rule.value.priority
    direction="Inbound"
    access="Allow"
    protocol="Tcp"
    source_port_range ="*"
    destination_port_range =security_rule.value.destination_port_range
    source_address_prefix="*"
    destination_address_prefix = "*"
  }
}

  
depends_on = [
    azurerm_resource_group.appgrp
  ]
}

