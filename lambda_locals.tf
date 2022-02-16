locals {
  s3_deployment_code_bucket = var.certificate_manager_code_s3_bucket != "" ? (
    var.certificate_manager_code_s3_bucket
    ) : (
    "cyral-dev-aholmquist"
  )
  s3_deployment_code_key = var.certificate_manager_code_s3_key != "" ? (
    var.certificate_manager_code_s3_key
    ) : (
    "certificate-manager.zip"
  )
}
