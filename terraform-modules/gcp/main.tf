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

resource "google_project_service" "container" {
  project = google_project.app_env.project_id
  service = "container.googleapis.com"
}

resource "google_container_cluster" "app_env" {
  depends_on = [google_project_service.container]
  provider   = google-beta
  project    = google_project.app_env.project_id
  name       = local.app_env_name
  location   = var.region
  release_channel {
    channel = "REGULAR"
  }
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {}
  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      maximum       = 32 * 400
    }
    resource_limits {
      resource_type = "memory"
      maximum       = 128 * 400
    }
  }
  initial_node_count = 1
}

module "gke_auth" {
  depends_on = [google_container_cluster.app_env]
  source     = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version    = "14.0.1"

  project_id   = google_project.app_env.project_id
  cluster_name = google_container_cluster.app_env.name
  location     = var.region
}

resource "local_file" "kubeconfig" {
  content         = module.gke_auth.kubeconfig_raw
  filename        = var.kubeconfig_path
  file_permission = "0600"
}
