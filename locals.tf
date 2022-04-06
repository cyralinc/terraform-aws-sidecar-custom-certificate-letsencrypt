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
    var.sidecar_certificate_casigned_role_arn != "" &&
    var.sidecar_certficate_casigned_secret_arn != ""
  )
}