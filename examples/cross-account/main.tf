# To deploy the Sidecar Certificate Manager for a sidecar hosted in a different
# AWS account, use the `sidecar_secrets_manager_role_arn` variable.
#
# The sidecar deployment should generate a proper IAM role to be used here, so
# you usually don't have to worry about it. If you want to understand how this
# role must look like, keep reading.
#
# Suppose the AWS account that deploys this module is 111111111111, and the
# account that hosts the sidecar is 222222222222. Then, the following
# properties must hold:
#
# 1. Permission must be granted for account 111111111111 to assume the role.
#
# 2. The role must allow the following actions:
#    - `secretsmanager:GetSecretValue`
#    - `secretsmanager:UpdateSecret`
#
# 3. On the following resource:
#    - `arn:aws:secretsmanager:us-east-1:222222222222:secret:/cyral/sidecars/certificate/*`
#
module "cyral_sidecar_certificate_manager" {
  source = "cyralinc/sidecar-certificate-manager/cyral"
  version = ">= 1.0.0"

  sidecar_domain = "my-sidecar.my-domain.com"
  sidecar_secrets_manager_role_arn = "arn:aws:iam::111111111111:role/sm-role"
}
