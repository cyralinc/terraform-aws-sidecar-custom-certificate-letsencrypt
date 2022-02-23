# Cyral Sidecar Certificate Manager module for Terraform

## Usage

```hcl
module "cyral_sidecar_certificate_manager" {
  source  = "cyralinc/sidecar-certificate-manager/cyral"
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
  # invoke this module. See examples/cross-account.
  sidecar_secrets_manager_role_arn = "arn:aws:iam::111111111111:role/sm-role"

  # We recommend you set an email to receive expiry notifications. In case the
  # feature fails to renew the certificate due to an extraordinary event, you
  # will know that something is wrong.
  registration_email = "me@example.com"
}
```

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
| <a name="input_certificate_manager_code_s3_bucket"></a> [certificate\_manager\_code\_s3\_bucket](#input\_certificate\_manager\_code\_s3\_bucket) | S3 bucket that contains the Certificate Manager Lambda deployment package. LEAVE EMPTY UNLESS YOU WANT TO OVERRIDE THE DEFAULT. | `string` | `""` | no |
| <a name="input_certificate_manager_code_s3_key"></a> [certificate\_manager\_code\_s3\_key](#input\_certificate\_manager\_code\_s3\_key) | Object key for the Lambda deployment package on the S3 bucket. LEAVE EMPTY UNLESS YOU WANT TO OVERRIDE THE DEFAULT. | `string` | `""` | no |
| <a name="input_certificate_manager_version"></a> [certificate\_manager\_version](#input\_certificate\_manager\_version) | Version of the Certificate Manager Lambda code. | `string` | `"v0.1.0"` | no |
| <a name="input_registration_email"></a> [registration\_email](#input\_registration\_email) | Administrative email to use for registration and recovery contact with Let's Encrypt. | `string` | `""` | no |
| <a name="input_renew_days_before_expiry"></a> [renew\_days\_before\_expiry](#input\_renew\_days\_before\_expiry) | Number of days before expiry date to renew the certificate. | `number` | `35` | no |
| <a name="input_renewal_interval_days"></a> [renewal\_interval\_days](#input\_renewal\_interval\_days) | How often to check if certificate should be renewed, in days. | `number` | `1` | no |
| <a name="input_sidecar_domain"></a> [sidecar\_domain](#input\_sidecar\_domain) | The domain to generate a certificate for. Ex: my-snowflake-sidecar.mydomain.com | `string` | n/a | yes |
| <a name="input_sidecar_secrets_manager_role_arn"></a> [sidecar\_secrets\_manager\_role\_arn](#input\_sidecar\_secrets\_manager\_role\_arn) | Role to assume when accessing secrets manager. Use this if the sidecar is hosted in another account. | `string` | `""` | no |
| <a name="input_sidecar_subdomains"></a> [sidecar\_subdomains](#input\_sidecar\_subdomains) | Subdomains to generate a certificate for, delimited by comma. Use SnowflakeAccountRegion instead, if configuring a Snowflake sidecar. | `string` | `""` | no |
| <a name="input_snowflake_account_region"></a> [snowflake\_account\_region](#input\_snowflake\_account\_region) | The AWS region your Snowflake account is running on. Ex: us-east-1 | `string` | `""` | no |
| <a name="input_staging_certificate"></a> [staging\_certificate](#input\_staging\_certificate) | Enter true to use a staging (test) certificate. ONLY FOR TESTING, A STAGING CERTIFICATE IS NOT VALID FOR PRODUCTION USE. | `string` | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | Secret containing the sidecar certificate |
