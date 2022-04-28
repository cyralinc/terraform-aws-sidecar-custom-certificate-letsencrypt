# Cross-account deployment

Use this example you have one AWS account where you manage your domains and 
another AWS account where the sidecar is deployed. Use parameters
`sidecar_custom_certificate_secret_arn` and `sidecar_custom_certificate_role_arn`
and assign them the values from the output of those variables with the same
name from the sidecar module.
