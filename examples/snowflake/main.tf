# To deploy the Sidecar Custom Certificate application for a Snowflake sidecar,
# use the parameter `snowflake_account_region` to inform which AWS region your
# Snowflake account is running on.
#
module "cyral_sidecar_custom_certificate" {
  source = "cyralinc/sidecar-custom-certificate-letsencrypt/aws"
  version = ">= 1.0.0"

  sidecar_domain = "my-sidecar.my-domain.com"
  snowflake_account_region = "us-east-1"
}
