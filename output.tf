locals {
  secret_id_output = local.create_certificate_secret ? (
    aws_secretsmanager_secret.certificate_secret[0].arn
    ) : (
    var.sidecar_custom_certificate_secret_arn
  )
}

output "secret_id" {
  value       = local.secret_id_output
  description = "Secret containing the TLS certificate that will be used by the sidecar."
}
