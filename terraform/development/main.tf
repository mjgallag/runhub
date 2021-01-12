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
  project_id      = local.project_id_name
  name            = local.project_id_name
  billing_account = data.google_billing_account.app_env.id
}

provider "google" {
  project = local.project_id_name
}

provider "google-beta" {
  project = local.project_id_name
}

resource "google_storage_bucket" "app_env" {
  for_each = toset([
    "terraform-state"
  ])
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
  depends_on = [google_project.app_env]
  service    = each.value
}

resource "google_artifact_registry_repository" "app_env" {
  for_each = local.is_dev ? toset([
    "app"
  ]) : toset([])
  depends_on    = [google_project_service.app_env["artifact_registry"]]
  provider      = google-beta
  repository_id = "app"
  location      = local.region
  format        = "DOCKER"
}
