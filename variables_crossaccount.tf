variable "sidecar_certficate_casigned_secret_arn" {
  description = "ARN of the secret to store the certificate in. Use this if the sidecar is hosted in another account."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^(arn:.+:secretsmanager:.+:[0-9]{12}:secret:.+)?$", var.sidecar_certficate_casigned_secret_arn))
    error_message = "Please use a valid IAM role ARN."
  }
}

variable "sidecar_certificate_casigned_role_arn" {
  description = "Role to assume when accessing secrets manager. Use this if the sidecar is hosted in another account."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^(arn:.+:iam::[0-9]{12}:role/.+)?$", var.sidecar_certificate_casigned_role_arn))
    error_message = "Please use a valid IAM role ARN."
  }
}
