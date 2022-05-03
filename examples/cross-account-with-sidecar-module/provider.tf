provider "aws" {
  alias   = "sidecar"
  region  = "us-east-1"
  profile = "sidecar_account"
}

provider "aws" {
  alias   = "custom_certificate"
  region  = "us-east-1"
  profile = "certificate_account"
}
