terraform {
  required_version = ">= 0.15.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.45"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/google"
      version = ">= 3.71"
    }
  }
}
