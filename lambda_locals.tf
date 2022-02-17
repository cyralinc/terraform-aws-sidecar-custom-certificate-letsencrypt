locals {
  s3_deployment_code_bucket = var.certificate_manager_code_s3_bucket != "" ? (
    var.certificate_manager_code_s3_bucket
    ) : (
    "cyral-public-assets-${local.region}"
  )
  s3_deployment_code_key = var.certificate_manager_code_s3_key != "" ? (
    var.certificate_manager_code_s3_key
    ) : (
    "sidecar-certificate-manager/v0.1.0/sidecar-certificate-manager-lambda-v0.1.0.zip"
  )
}
