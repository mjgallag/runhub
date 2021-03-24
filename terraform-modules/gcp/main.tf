locals {
  app_env_name = join("-", [var.env, var.app])
  is_dev       = var.env == "dev"
}

data "google_billing_account" "app_env" {
  display_name = var.billing_account
  open         = true
}

resource "google_project" "app_env" {
  project_id      = local.app_env_name
  name            = local.app_env_name
  billing_account = data.google_billing_account.app_env.id
}

resource "google_storage_bucket" "terraform_state" {
  project                     = google_project.app_env.project_id
  name                        = join("-", [local.app_env_name, "terraform-state"])
  location                    = var.region
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}
