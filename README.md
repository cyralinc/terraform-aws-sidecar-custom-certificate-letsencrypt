# Let's Encrypt-signed custom certificate module for Terraform

 See the [sidecar certificates](https://cyral.com/docs/sidecars/sidecar-certificates#custom-certificate) main
 page and the [Terraform certificate](https://cyral.com/docs/sidecars/terraform/certificate#lets-encrypt-signed-certificate)
 documentation for more information on how to use this module.
 
## Usage

```terraform
module "cyral_sidecar_custom_certificate_letsencrypt" {
  source  = "cyralinc/sidecar-custom-certificate-letsencrypt/cyral"
  version = ">= 1.0.0"

  # Required

  sidecar_domain = "my-sidecar.my-domain.com"

  # Optional

  # Use to manually input a list of subdomains for the sidecar. Subdomains are
  # delimited by comma.
  sidecar_subdomains = "*.my-sidecar.my-domain.com,*.foo.my-sidecar.my-domain.com"

  # Use if configuring a certificate for a sidecar bound to Snowflake. See
  # examples/snowflake.
  snowflake_account_region = "us-east-1"

  # Use if AWS account that hosts the sidecar is different from the one used to
  # invoke this module. See also variable 'sidecar_custom_certificate_secret_arn',
  # and examples/cross-account for a full example.
  sidecar_custom_certificate_role_arn = "arn:aws:iam::111111111111:role/sm-role"

  # We recommend you set an email to receive expiry notifications. In case the
  # feature fails to renew the certificate due to an extraordinary event, you
  # will know that something is wrong.
  registration_email = "me@example.com"
}
```

## Debugging

Debugging information can be found in the CloudWatch log stream created by the
[lambda](lambda_resources.tf). The lambda name is set to 
`CyralSidecarCustomCertificate-RANDOM_ID` where `RANDOM_ID`is a random
identifier created at deployment time.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.22.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.renewal_event](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.renewal_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.lambda_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_invocation.first_invocation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_invocation) | resource |
| [aws_lambda_permission.renewal_trigger_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_secretsmanager_secret.certificate_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [random_id.current](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.lambda_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lambda_code_s3_bucket"></a> [lambda\_code\_s3\_bucket](#input\_lambda\_code\_s3\_bucket) | S3 bucket that contains the Lambda deployment package. LEAVE EMPTY UNLESS YOU WANT TO OVERRIDE THE DEFAULT. | `string` | `""` | no |
| <a name="input_lambda_code_s3_key"></a> [lambda\_code\_s3\_key](#input\_lambda\_code\_s3\_key) | Object key for the Lambda deployment package on the S3 bucket. LEAVE EMPTY UNLESS YOU WANT TO OVERRIDE THE DEFAULT. | `string` | `""` | no |
| <a name="input_lambda_code_version"></a> [lambda\_code\_version](#input\_lambda\_code\_version) | Version of the Sidecar Custom Certificate Lambda code. | `string` | `"v0.3.0"` | no |
| <a name="input_registration_email"></a> [registration\_email](#input\_registration\_email) | Administrative email to use for registration and recovery contact with Let's Encrypt. | `string` | `""` | no |
| <a name="input_renewal_interval_checks"></a> [renewal\_interval\_checks](#input\_renewal\_interval\_checks) | How often to check if certificate should be renewed, in days. | `number` | `1` | no |
| <a name="input_renewal_interval_window_start"></a> [renewal\_interval\_window\_start](#input\_renewal\_interval\_window\_start) | Number of days before expiry date to renew the certificate. | `number` | `35` | no |
| <a name="input_sidecar_custom_certificate_role_arn"></a> [sidecar\_custom\_certificate\_role\_arn](#input\_sidecar\_custom\_certificate\_role\_arn) | Role to assume when accessing secrets manager. Use this if the sidecar is hosted in another account. | `string` | `""` | no |
| <a name="input_sidecar_custom_certificate_secret_arn"></a> [sidecar\_custom\_certificate\_secret\_arn](#input\_sidecar\_custom\_certificate\_secret\_arn) | ARN of the secret to store the certificate in. Use this if the sidecar is hosted in another account. | `string` | `""` | no |
| <a name="input_sidecar_domain"></a> [sidecar\_domain](#input\_sidecar\_domain) | The domain to generate a certificate for. Ex: my-snowflake-sidecar.mydomain.com | `string` | n/a | yes |
| <a name="input_sidecar_subdomains"></a> [sidecar\_subdomains](#input\_sidecar\_subdomains) | Subdomains to generate a certificate for, delimited by comma. Use SnowflakeAccountRegion instead, if configuring a Snowflake sidecar. | `string` | `""` | no |
| <a name="input_snowflake_account_region"></a> [snowflake\_account\_region](#input\_snowflake\_account\_region) | The AWS region your Snowflake account is running on. Ex: us-east-1 | `string` | `""` | no |
| <a name="input_staging_certificate"></a> [staging\_certificate](#input\_staging\_certificate) | Enter true to use a staging (test) certificate. ONLY FOR TESTING, A STAGING CERTIFICATE IS NOT VALID FOR PRODUCTION USE. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_secret_arn"></a> [certificate\_secret\_arn](#output\_certificate\_secret\_arn) | ARN of the secret containing the TLS certificate that will be used by the sidecar. |
