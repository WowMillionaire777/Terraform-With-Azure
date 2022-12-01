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

locals {
  resource_group_name = "app-grp"
  location            = "East US"
  virtual_network = {
    name          = "app-network"
    address_space = "10.0.0.0/16"
  }
  subnets = [
    {
      name           = "SubnetA",
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "SubnetB",
      address_prefix = "10.0.2.0/24"
    }
  ]
}

resource "azurerm_resource_group" "appgrp" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_virtual_network" "appnetwork" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtual_network.address_space]

  depends_on = [
    azurerm_resource_group.appgrp
  ]

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "subnetA" {
  name                 = local.subnets[0].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = [local.subnets[0].address_prefix]
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}

resource "azurerm_subnet" "subnetB" {
  name                 = local.subnets[1].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = [local.subnets[1].address_prefix]
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}

resource "azurerm_network_interface" "appinterface" {
  name                = "appinterface"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_subnet.subnetA
  ]
}
