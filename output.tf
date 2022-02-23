output "secret_id" {
  value       = jsondecode(aws_lambda_invocation.first_invocation.result).SecretId
  description = "Secret containing the sidecar certificate"
}
