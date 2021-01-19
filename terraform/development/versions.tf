terraform {
  required_version = ">= 0.14.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.52.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.52.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.2"
    }
  }
}
