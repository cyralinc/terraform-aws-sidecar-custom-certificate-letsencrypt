resource "aws_secretsmanager_secret" "certificate_secret" {
  name                    = "/cyral/sidecars/certificate/${random_id.current.id}"
  recovery_window_in_days = 30
}
