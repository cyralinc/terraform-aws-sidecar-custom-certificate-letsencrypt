output "secret_id" {
  value       = aws_secretsmanager_secret.certificate_secret[0].arn
  description = "Secret containing the TLS certificate that will be used by the sidecar."
}
