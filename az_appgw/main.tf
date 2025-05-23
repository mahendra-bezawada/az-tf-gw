provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-appgw-demo"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-appgw"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-appgw"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = "pip-appgw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "appgw" {
  name                = "appgw-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = azurerm_subnet.subnet.id
  }

  frontend_port {
    name = "frontendPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "appgw-fe"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  ssl_profile {
    name = var.ssl_profile[0].name

    ssl_policy {
      policy_name          = var.ssl_profile[0].ssl_policy[0].policy_name
      policy_type          = var.ssl_profile[0].ssl_policy[0].policy_type
      min_protocol_version = coalesce(var.ssl_profile[0].ssl_policy[0].protocol_version, "TLSv1_2")
      cipher_suites        = var.ssl_profile[0].ssl_policy[0].policy_type == "Custom" ? var.ssl_profile[0].ssl_policy[0].cipher_suites : null
    }
  }

  lifecycle {
    ignore_changes = [ssl_profile] # optional, useful for testing
  }

  depends_on = [azurerm_public_ip.pip]
}
