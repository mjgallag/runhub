locals {
  project_id_name = join("-", [var.environment, var.app, "rh", "v${var.project_version}"])
  location        = join("-", slice(split("-", var.zone), 0, 2))
  isDev           = var.environment == "dev"
}

data "google_billing_account" "app_env" {
  display_name = var.billing_account
  open         = true
}

resource "google_project" "app_env" {
  project_id          = local.project_id_name
  name                = local.project_id_name
  billing_account     = data.google_billing_account.app_env.id
  auto_create_network = false
}

resource "google_project_default_service_accounts" "app_env" {
  project = google_project.app_env.project_id
  action  = "DELETE"
}

resource "google_storage_bucket" "app_env_terraform_state" {
  project                     = google_project.app_env.project_id
  name                        = join("-", [google_project.app_env.project_id, "terraform", "state"])
  location                    = local.location
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

resource "google_project_service" "app_env_artifact_registry" {
  count   = local.isDev ? 1 : 0
  project = google_project.app_env.project_id
  service = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "app_env_app" {
  count         = local.isDev ? 1 : 0
  depends_on    = [google_project_service.app_env_artifact_registry[0]]
  provider      = google-beta
  project       = google_project.app_env.project_id
  repository_id = "app"
  location      = local.location
  format        = "DOCKER"
}
