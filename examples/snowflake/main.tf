module "cyral_sidecar_custom_certificate" {
  source = "cyralinc/sidecar-custom-certificate-letsencrypt/aws"
  version = ">= 1.0.0"

  sidecar_domain = "my-sidecar.my-domain.com"
  snowflake_account_region = "us-east-1"
}
