output "certificate_secret_arn" {
  description = "Secret containing the TLS certificate that will be used by the sidecar."
  value       = aws_secretsmanager_secret.certificate_secret.arn
}
