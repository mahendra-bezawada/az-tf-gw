variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}


variable "ssl_profile" {
  description = "List of SSL profiles with optional nested ssl_policy"
  type = list(object({
    name        = string
    ssl_policy = object({
      min_protocol_version = optional(string)
    })
  }))
}

variable "ssl_policy" {
  description = "List of SSL policy settings to override or use globally"
  type = list(object({
    policy_type          = string
    policy_name          = string
  }))
}


/*
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
*/
