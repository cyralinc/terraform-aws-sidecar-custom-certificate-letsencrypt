terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      version = ">= 3.22.0"
      source  = "hashicorp/aws"
    }
    random = {
      version = ">= 3.1.0"
      source  = "hashicorp/random"
    }
  }
}
