variable "sidecar_domain" {
  description = "The domain to generate a certificate for. Ex: my-snowflake-sidecar.mydomain.com"
  type        = string
  default     = ""

  validation {
    condition     = var.sidecar_domain != ""
    error_message = "The sidecar domain cannot be empty."
  }
}

variable "sidecar_subdomains" {
  description = "Subdomains to generate a certificate for, delimited by comma. Use SnowflakeAccountRegion instead, if configuring a Snowflake sidecar."
  type        = string
  default     = ""
}

variable "registration_email" {
  description = "Administrative email to use for registration and recovery contact with Let's Encrypt."
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

variable "certificate_secret_suffix" {
  description = "Name suffix of the secret that will store the certificate. Default is the name of this stack."
  type        = string
  default     = ""
}

variable "renewal_interval_days" {
  description = "How often to check if certificate should be renewed, in days."
  type        = number
  default     = 1

  validation {
    condition     = 1 <= var.renewal_interval_days && var.renewal_interval_days <= 14
    error_message = "Valid values range from 1 to 14."
  }
}

variable "renew_days_before_expiry" {
  description = "Number of days before expiry date to renew the certificate."
  type        = number
  default     = 35

  validation {
    condition     = (30 <= var.renew_days_before_expiry && var.renew_days_before_expiry <= 60)
    error_message = "Valid values range from 30 to 60."
  }
}

variable "sidecar_secrets_manager_role_arn" {
  description = "Role to assume when accessing secrets manager. Use this if the sidecar is hosted in another account."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^(arn:.+:iam::[0-9]{12}:role/.+)?$", var.sidecar_secrets_manager_role_arn))
    error_message = "Please use a valid IAM role ARN."
  }
}
