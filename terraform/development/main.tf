locals {
  project_id_name = join("-", [var.environment, var.app, "rh", "v${var.project_version}"])
  region          = join("-", slice(split("-", var.zone), 0, 2))
  is_dev          = var.environment == "dev"
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

resource "google_storage_bucket" "app_env" {
  for_each = toset([
    "terraform-state"
  ])
  project                     = google_project.app_env.project_id
  name                        = join("-", [google_project.app_env.project_id, each.value])
  location                    = local.region
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

resource "google_project_service" "app_env" {
  for_each = local.is_dev ? {
    artifact_registry = "artifactregistry.googleapis.com"
  } : {}
  project = google_project.app_env.project_id
  service = each.value
}

resource "google_artifact_registry_repository" "app_env" {
  for_each = local.is_dev ? toset([
    "app"
  ]) : toset([])
  depends_on    = [google_project_service.app_env["artifact_registry"]]
  provider      = google-beta
  project       = google_project.app_env.project_id
  repository_id = "app"
  location      = local.region
  format        = "DOCKER"
}
