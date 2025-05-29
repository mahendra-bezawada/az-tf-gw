#ssl_policy = {
#  policy_type          = "Predefined"
#  policy_name          = "AppGwSslPolicy20220101"
#  min_protocol_version = "TLSv1_2"
#}

ssl_profile = [
  {
    name = "mySSLProfile"
    ssl_policy = {
      policy_type          = "Predefined"
      policy_name          = "AppGwSslPolicy20170401S"
      min_protocol_version = "TLSv1_2"
    }
  }
]

certificate_password = "TestingPassword123!"

resource_group_name = "rg-appgw-demo"
location            = "eastus"

subnet_id = "/subscriptions/bb81a390-6789-4184-a745-a5cfe71c2004/resourceGroups/rg-appgw-demo/providers/Microsoft.Network/virtualNetworks/vnet-appgw/subnets/subnet-appgw"
vnet_name = "vnet-appgw"
public_ip = "/subscriptions/bb81a390-6789-4184-a745-a5cfe71c2004/resourceGroups/rg-appgw-demo/providers/Microsoft.Network/publicIPAddresses/pip-appgw"