locals {
  should_use_different_account = var.sidecar_secrets_manager_role_arn != ""
}
