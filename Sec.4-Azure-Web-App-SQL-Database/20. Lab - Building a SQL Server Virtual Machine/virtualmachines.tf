resource "azurerm_network_interface" "dbinterface" {  
  name                = "dbinterface"
  location            = local.location  
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dbsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.dbip.id
  }

  depends_on = [
    azurerm_virtual_network.appnetwork,
    azurerm_public_ip.dbip
  ]
}

resource "azurerm_public_ip" "dbip" { 
  name                = "db-ip"
  resource_group_name = local.resource_group_name
  location            = local.location  
  allocation_method   = "Static"
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}


resource "azurerm_windows_virtual_machine" "dbvm" {  
  name                = "dbvm"
  resource_group_name = local.resource_group_name
  location            = local.location 
  size                = "Standard_D2s_v3"
  admin_username      = "dbuser"
  admin_password      = "Azure@123"  
  network_interface_ids = [
    azurerm_network_interface.dbinterface.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftSQLServer"
    offer     = "sql2019-ws2019"
    sku       = "sqldev"
    version   = "15.0.220510"
  }

   
  depends_on = [
    azurerm_virtual_network.appnetwork,
    azurerm_network_interface.dbinterface
  ]
}


resource "azurerm_mssql_virtual_machine" "mssqlmachine" {
  virtual_machine_id = azurerm_windows_virtual_machine.dbvm.id
  sql_license_type   = "PAYG"
}