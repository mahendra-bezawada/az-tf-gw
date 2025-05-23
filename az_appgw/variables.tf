variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "ssl_profile" {
  description = "AppGateway SSL profile"
  type = list(object({
    name       = string
    ssl_policy = list(object({
      policy_name         = string
      policy_type         = string
      cipher_suites       = list(string)
      protocol_version    = string
    }))
  }))
}
