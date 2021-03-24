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

module "google_container_cluster_auth" {
  depends_on = [google_container_cluster.app_env]
  source     = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version    = "14.0.1"

  project_id   = google_project.app_env.project_id
  cluster_name = google_container_cluster.app_env.name
  location     = var.region
}

resource "local_file" "kubeconfig" {
  content         = module.google_container_cluster_auth.kubeconfig_raw
  filename        = var.kubeconfig_path
  file_permission = "0600"
}
