ssl_policy = {
  policy_type          = "Predefined"
  policy_name          = "AppGwSslPolicy20220101"
  min_protocol_version = "TLSv1_2"
}

ssl_profile = [
  {
    name = "mySSLProfile"
    ssl_policy = {
      policy_type          = "Predefined"
      policy_name          = "AppGwSslPolicy20220101"
      min_protocol_version = "TLSv1_2"
    }
  }
]

certificate_password = "TestingPassword123!"

resource_group_name = "rg-appgw-demo"
location            = "eastus"