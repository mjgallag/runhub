locals {
  app_env_name    = join("-", [var.environment, var.app])
  project_id_name = join("-", [local.app_env_name, "rh", "v${var.project_version}"])
  region          = join("-", slice(split("-", var.zone), 0, 2))
  is_dev          = var.environment == "dev"
  project_services_shared = {
    container = "container.googleapis.com"
  }
  project_services = {
    dev = merge({
      artifactregistry = "artifactregistry.googleapis.com"
    }, local.project_services_shared)
    prod = merge({}, local.project_services_shared)
  }
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
  for_each = local.is_dev ? local.project_services.dev : local.project_services.prod
  project  = google_project.app_env.project_id
  service  = each.value
}

resource "google_artifact_registry_repository" "app_env" {
  for_each = local.is_dev ? toset([
    "app"
  ]) : toset([])
  depends_on    = [google_project_service.app_env["artifactregistry"]]
  provider      = google-beta
  project       = google_project.app_env.project_id
  repository_id = "app"
  location      = local.region
  format        = "DOCKER"
}

resource "google_container_cluster" "app_env" {
  depends_on = [google_project_service.app_env["container"]]
  provider   = google-beta
  project    = google_project.app_env.project_id
  name       = local.app_env_name
  location   = var.zone
  release_channel {
    channel = "REGULAR"
  }
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {}
  initial_node_count = 1
  node_config {
    machine_type = "n1-standard-1"
  }
  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 0
      maximum       = 12
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 0
      maximum       = 45
    }
  }
}
