variable "lambda_code_version" {
  description = "Version of the Sidecar Custom Certificate Lambda code."
  type        = string
  default     = "v1.0.0"
}

variable "lambda_code_s3_bucket" {
  description = "S3 bucket that contains the Lambda deployment package. LEAVE EMPTY UNLESS YOU WANT TO OVERRIDE THE DEFAULT."
  type        = string
  default     = ""
}

variable "lambda_code_s3_key" {
  description = "Object key for the Lambda deployment package on the S3 bucket. LEAVE EMPTY UNLESS YOU WANT TO OVERRIDE THE DEFAULT."
  type        = string
  default     = ""
}
