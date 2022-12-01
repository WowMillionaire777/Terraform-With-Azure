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
