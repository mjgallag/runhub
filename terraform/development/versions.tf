terraform {
  required_version = ">= 0.14.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "= 3.51.1"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "3.51.1"
    }
  }
}
