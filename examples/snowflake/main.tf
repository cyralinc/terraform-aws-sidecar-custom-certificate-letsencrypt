# To deploy the Sidecar Certificate Manager for a Snowflake sidecar, you don't
# need to specify `sidecar_subdomains`. Just use `snowflake_account_region`,
# and the application will use a set of predefined subdomains.
module "cyral_sidecar_certificate_manager" {
  source = "cyralinc/sidecar-certificate-manager/cyral"
  version = ">= 1.0.0"

  sidecar_domain = "my-sidecar.my-domain.com"
  snowflake_account_region = "us-east-1"
}
