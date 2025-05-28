variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "ssl_profile" {
  description = "AppGateway SSL profile"
  type = list(object({
    name       = string
    ssl_policy = object({
      policy_name      = string
      policy_type      = string
      min_protocol_version = optional(string)
    })
  }))
  default = [
      {
        name = "defaultSSLProfile"
        ssl_policy = {
          policy_name      = "AppGwSslPolicy20170401S"
          policy_type      = "Predefined"
          min_protocol_version = null
        }
      }
    ]
}
