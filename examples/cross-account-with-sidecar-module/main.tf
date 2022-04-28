# The sidecar module will output the exact same parameters once you provide the
# `sidecar_custom_certificate_account_id` as an input. In the example below, the
# account where the certificate will be created is `111111111111` and the sidecar
# is running in a different account:
#
local {
    sidecar_dns_name = "sidecar.mycompany.com"
}

module "cyral_sidecar" {
    providers = {
        aws = aws.sidecar
    }

    source  = "cyralinc/sidecar-aws/cyral"
    version = ">= 2.7.0"

    sidecar_custom_certificate_account_id = "111111111111"
    sidecar_dns_name = locals.sidecar_dns_name

    ...
}

module "cyral_sidecar_custom_certificate" {
    providers = {
        aws = aws.custom_certificate
    }
    source = "cyralinc/sidecar-custom-certificate-letsencrypt/cyral"
    version = ">= 1.0.0"

    sidecar_domain = locals.sidecar_dns_name
    sidecar_custom_certificate_secret_arn = module.sidecar_custom_certificate_secret_arn
    sidecar_custom_certificate_role_arn = module.sidecar_custom_certificate_role_arn
}
