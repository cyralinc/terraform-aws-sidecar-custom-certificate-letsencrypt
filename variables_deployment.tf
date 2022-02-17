variable "deployment_id" {
  description = "Identifier used to generate unique resource names. This is equivalent to AWS' CloudFormation stack name."
  type        = string
  default     = ""

  validation {
    condition     = var.deployment_id != ""
    error_message = "The deployment identifier cannot be empty."
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
