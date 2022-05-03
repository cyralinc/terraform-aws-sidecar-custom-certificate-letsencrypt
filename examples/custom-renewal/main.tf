module "cyral_sidecar_custom_certificate_letsencrypt" {
  source  = "cyralinc/sidecar-custom-certificate-letsencrypt/aws"
  version = ">= 1.0.0"

  sidecar_domain                = "my-sidecar.my-domain.com"
  renewal_interval_checks       = 1
  renewal_interval_window_start = 30
}
