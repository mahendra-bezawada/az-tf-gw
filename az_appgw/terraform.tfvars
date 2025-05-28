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
