locals {
  create_certificate_secret = !local.should_use_different_account
}

resource "aws_secretsmanager_secret" "certificate_secret" {
  count                   = local.create_certificate_secret ? 1 : 0
  name                    = "/cyral/sidecars/certificate/${random_id.current.id}"
  recovery_window_in_days = 30
}
