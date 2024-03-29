variable "sidecar_domain" {
  description = "The domain to generate a certificate for. Ex: my-snowflake-sidecar.mydomain.com"
  type        = string
}

variable "sidecar_subdomains" {
  description = "Subdomains to generate a certificate for, delimited by comma. Use SnowflakeAccountRegion instead, if configuring a Snowflake sidecar."
  type        = string
  default     = ""
}

variable "snowflake_account_region" {
  description = "The AWS region your Snowflake account is running on. Ex: us-east-1"
  type        = string
  default     = ""

  validation {
    condition = contains([
      "",
      "us-east-1",
      "us-east-2",
      "us-west-1",
      "us-west-2",
      "us-gov-east-1",
      "us-gov-west-1",
      "ca-central-1",
      "eu-central-1",
      "eu-west-1",
      "eu-west-2",
      "eu-west-3",
      "eu-north-1",
      "eu-south-1",
      "ap-east-1",
      "ap-south-1",
      "ap-southeast-1",
      "ap-southeast-2",
      "ap-southeast-3",
      "ap-northeast-1",
      "ap-northeast-2",
      "ap-northeast-3",
      "sa-east-1",
      "me-south-1",
      "af-south-1"
    ], var.snowflake_account_region)
    error_message = "Please enter a valid AWS region name."
  }
}

variable "registration_email" {
  description = "Administrative email to use for registration and recovery contact with Let's Encrypt."
  type        = string
  default     = ""
}

variable "renewal_interval_checks" {
  description = "How often to check if certificate should be renewed, in days."
  type        = number
  default     = 1

  validation {
    condition     = 1 <= var.renewal_interval_checks && var.renewal_interval_checks <= 14
    error_message = "Valid values range from 1 to 14."
  }
}

variable "renewal_interval_window_start" {
  description = "Number of days before expiry date to renew the certificate."
  type        = number
  default     = 35

  validation {
    condition     = (30 <= var.renewal_interval_window_start && var.renewal_interval_window_start <= 60)
    error_message = "Valid values range from 30 to 60."
  }
}

variable "staging_certificate" {
  description = "Enter true to use a staging (test) certificate. ONLY FOR TESTING, A STAGING CERTIFICATE IS NOT VALID FOR PRODUCTION USE."
  type        = bool
  default     = false
}
