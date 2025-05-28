/*
ssl_profile = [
  {
    name = "mySSLProfile"
    ssl_policy = {
      policy_name      = "AppGwSslPolicy20220101S"
      policy_type      = "Predefined"
      min_protocol_version = null
    }
  }
]
*/

ssl_profile = [
  {
    name = "mySSLProfile"
  }
]

ssl_policy = [
  {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101"
  }
]

