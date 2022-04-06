# To deploy the Sidecar Certificate CA-Signed application for a sidecar hosted
# in a different AWS account, use the `sidecar_certificate_casigned_secret_arn`
# and `sidecar_certificate_casigned_role_arn` variables.
#
# The sidecar deployment should output the correct values to be used here, so
# usually you only need to copy those values over to these variables, as shown
# below.
module "cyral_sidecar_certificate_casigned" {
  source = "cyralinc/sidecar-certificate-casigned/cyral"
  version = ">= 1.0.0"

  sidecar_domain = "my-sidecar.my-domain.com"
  sidecar_certificate_casigned_secret_arn = "arn:aws:secretsmanager:us-east-1:111111111111:secret:/cyral/sidecars/certificate/MySidecar-abcdef"
  sidecar_certificate_casigned_role_arn = "arn:aws:iam::222222222222:role/sm-role"
}
