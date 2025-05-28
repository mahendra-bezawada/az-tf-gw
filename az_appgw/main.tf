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

  frontend_ip_configuration {
    name                 = "appgw-fe"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  frontend_port {
    name = "frontendPort"
    port = 443
  }

  dynamic "ssl_profile" {
    for_each = var.ssl_profile
    content {
        name = ssl_profile.value.name

      dynamic "ssl_policy" {
      for_each = var.ssl_policy
      policy_name          = ssl_profile.value.ssl_policy.policy_name
      min_protocol_version = ssl_profile.value.ssl_policy.min_protocol_version
        min_protocol_version = coalesce(
          ssl_profile.value.ssl_policy.min_protocol_version,
          "TLSv1_2"
        )
      }
    }
}




  backend_address_pool {
    name = "appgw-backend-pool"

  }

  backend_http_settings {
    name                  = "appgw-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "appgw-listener"
    frontend_ip_configuration_name = "appgw-fe"
    frontend_port_name             = "frontendPort"
    protocol                       = "Https"
    ssl_profile_name               = var.ssl_profile[0].name
  }

  request_routing_rule {
    name                       = "appgw-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "appgw-listener"
    backend_address_pool_name  = "appgw-backend-pool"
    backend_http_settings_name = "appgw-http-settings"
  }
}

