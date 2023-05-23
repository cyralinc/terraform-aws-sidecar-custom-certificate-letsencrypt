resource "aws_secretsmanager_secret" "certificate_secret" {
  name                    = "/cyral/sidecars/certificate/${random_id.current.id}"
  description             = "Custom TLS certificate consumed by Cyral sidecar."
  recovery_window_in_days = 30
}
