# Cross-account deployment combined with the sidecar module for AWS

Use this example you have one AWS account where you manage your domains and 
another AWS account where the sidecar is deployed. In this example, the input
parameters `sidecar_custom_certificate_secret_arn` and `sidecar_custom_certificate_role_arn`
are assigned directly from the output of the sidecar module. See [`provider.tf`](./provider.tf)
and the `providers` section of each module declaration to understand how to use
multiple AWS accounts in Terraform at the same time. 
