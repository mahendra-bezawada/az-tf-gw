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
      protocol_version = optional(string)
    })
  }))
}
