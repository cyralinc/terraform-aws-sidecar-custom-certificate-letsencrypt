# If you wish to customize how often the application checks and renews the
# sidecar certificate, use the variables `renewal_interval_checks` and
# `renewal_interval_window_start`.
#
# For the configuration below, the application will check the certificate every
# day, and renew if there are no more than 30 days left until it expires.
module "cyral_sidecar_custom_certificate" {
  source = "cyralinc/sidecar-custom-certificate-letsencrypt/cyral"
  version = ">= 1.0.0"

  sidecar_domain = "my-sidecar.my-domain.com"
  renewal_interval_checks = 1
  renewal_interval_window_start = 30
}
