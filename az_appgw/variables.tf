variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

#variable "ssl_policy" {
#  description = "Global SSL policy applied to all ssl_profiles"
#  type = object({
#    policy_type          = string
#    policy_name          = string
#    min_protocol_version = string
#  })
#}


variable "ssl_profile" {
  type = list(object({
    name       = string
    ssl_policy = object({
      policy_type          = string
      policy_name          = string
      min_protocol_version = string
    })
  }))
}

variable "certificate_password" {
  description = "Password for the PFX certificate."
  type        = string
}


/*
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
*/


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

variable "resource_group_name" {
  description = "The name of an existing resource group"
  type        = string
}

variable "subnet_id" {
  description = "The name of an existing subnet group"
  type        = string
}


variable "vnet_name" {
  description = "The name of an existing vnet"
  type        = string
}


variable "public_ip" {
  description = "The name of an existing public_ip"
  type        = string
}

