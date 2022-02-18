resource "aws_secretsmanager_secret" "certificate-secret" {
  name                    = "/cyral/sidecars/certificate/${random_id.current.id}"
  recovery_window_in_days = 30
}
