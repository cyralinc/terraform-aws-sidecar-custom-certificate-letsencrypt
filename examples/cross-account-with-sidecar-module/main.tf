locals {
    sidecar_dns_name = "sidecar.mycompany.com"
}

module "cyral_sidecar" {
    providers = {
        aws = aws.sidecar
    }

    source  = "cyralinc/sidecar-aws/cyral"
    version = ">= 2.7.0"

    sidecar_custom_certificate_account_id = "111111111111"
    sidecar_dns_name = local.sidecar_dns_name

    ## Remaining of your code goes here...
}

module "cyral_sidecar_custom_certificate" {
    providers = {
        aws = aws.custom_certificate
    }
    source = "cyralinc/sidecar-custom-certificate-letsencrypt/aws"
    version = ">= 1.0.0"

    sidecar_domain = local.sidecar_dns_name
    sidecar_custom_certificate_secret_arn = module.cyral_sidecar.sidecar_custom_certificate_secret_arn
    sidecar_custom_certificate_role_arn = module.cyral_sidecar.sidecar_custom_certificate_role_arn
}
