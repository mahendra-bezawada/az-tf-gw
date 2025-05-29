terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  
  api_versions_override = {
    "Microsoft.Network/applicationGateways" = "2023-02-01"
  }
}