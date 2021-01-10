locals {
  project_id_name = join("-", [var.environment, var.app, "rh", "v${var.project_version}"])
  location        = join("-", slice(split("-", var.zone), 0, 2))
}

data "google_billing_account" "billing_account" {
  display_name = var.billing_account
  open         = true
}

resource "google_project" "project" {
  project_id          = local.project_id_name
  name                = local.project_id_name
  billing_account     = data.google_billing_account.billing_account.id
  auto_create_network = false
}

resource "google_project_default_service_accounts" "project_default_service_accounts" {
  project = google_project.project.project_id
  action  = "DELETE"
}

resource "google_storage_bucket" "terraform_state_storage_bucket" {
  project                     = google_project.project.project_id
  name                        = join("-", [google_project.project.project_id, "terraform", "state"])
  location                    = local.location
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}
