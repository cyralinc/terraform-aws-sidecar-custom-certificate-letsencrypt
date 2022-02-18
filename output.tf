output "secret_id" {
  value       = jsondecode(aws_lambda_invocation.first-invocation.result).SecretId
  description = "Secret containing the sidecar certificate"
}
