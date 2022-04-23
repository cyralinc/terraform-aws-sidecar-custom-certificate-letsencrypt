# If you wish to customize how often the application checks and renews the
# sidecar certificate, use the variables `renewal_interval_days` and
# `renew_days_before_expiry`.
#
# For the configuration below, the application will check the certificate every
# day, and renew if there are no more than 30 days left until expiry.
module "cyral_sidecar_custom_certificate" {
  source = "cyralinc/sidecar-custom-certificate-letsencrypt/cyral"
  version = ">= 1.0.0"

  sidecar_domain = "my-sidecar.my-domain.com"
  renewal_interval_days = 1
  renew_days_before_expiry = 30
}
