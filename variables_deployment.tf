variable "certificate_manager_version" {
  description = "Version of the Certificate Manager Lambda code."
  type        = string
  default     = "v0.1.0"

  validation {
    condition     = var.certificate_manager_version != ""
    error_message = "Certificate manager version and s3 location (bucket and key) cannot both be empty."
  }
}

variable "certificate_manager_code_s3_bucket" {
  description = "S3 bucket that contains the Certificate Manager Lambda deployment package. LEAVE EMPTY UNLESS YOU WANT TO OVERRIDE THE DEFAULT."
  type        = string
  default     = ""
}

variable "certificate_manager_code_s3_key" {
  description = "Object key for the Lambda deployment package on the S3 bucket. LEAVE EMPTY UNLESS YOU WANT TO OVERRIDE THE DEFAULT."
  type        = string
  default     = ""
}
