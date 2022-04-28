# To deploy the Sidecar Custom Certificate application for a sidecar hosted in a
# different AWS account, use the `sidecar_custom_certificate_secret_arn` and
# `sidecar_custom_certificate_role_arn` variables.
#
module "cyral_sidecar_custom_certificate" {
  source = "cyralinc/sidecar-custom-certificate-letsencrypt/aws"
  version = ">= 1.0.0"

  sidecar_domain = "my-sidecar.my-domain.com"
  sidecar_custom_certificate_secret_arn = "arn:aws:secretsmanager:us-east-1:111111111111:secret:/cyral/sidecars/certificate/MySidecar-abcdef"
  sidecar_custom_certificate_role_arn = "arn:aws:iam::222222222222:role/sm-role"
}
