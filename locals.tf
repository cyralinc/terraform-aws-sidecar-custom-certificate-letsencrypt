# AWS info
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}

locals {
  # AWS info
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
  partition  = data.aws_partition.current.id

  # Other
  should_use_different_account = (
    var.sidecar_custom_certificate_role_arn != "" &&
    var.sidecar_custom_certificate_secret_arn != ""
  )
}
