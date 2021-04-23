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
  vertical_pod_autoscaling {
    enabled = true
  }
  cluster_autoscaling {
    enabled             = false
    autoscaling_profile = "OPTIMIZE_UTILIZATION"
  }
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/17"
    services_ipv4_cidr_block = "/22"
  }
  default_max_pods_per_node   = 32
  enable_intranode_visibility = true
  addons_config {
    dns_cache_config {
      enabled = true
    }
  }
  enable_shielded_nodes = true
  workload_identity_config {
    identity_namespace = "${google_project.app_env.project_id}.svc.id.goog"
  }
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "default_pool" {
  project            = google_project.app_env.project_id
  name               = "default-pool"
  location           = var.region
  cluster            = google_container_cluster.app_env.name
  initial_node_count = 1
}

resource "google_container_node_pool" "e2_medium_pool" {
  project  = google_project.app_env.project_id
  name     = "e2-medium-pool"
  location = var.region
  cluster  = google_container_cluster.app_env.name
  autoscaling {
    min_node_count = 0
    max_node_count = 1000
  }
}

resource "google_container_node_pool" "e2_standard_4_pool" {
  project  = google_project.app_env.project_id
  name     = "e2-standard-4-pool"
  location = var.region
  cluster  = google_container_cluster.app_env.name
  node_config {
    machine_type = "e2-standard-4"
  }
  autoscaling {
    min_node_count = 0
    max_node_count = 1000
  }
}

module "google_container_cluster_auth" {
  depends_on = [google_container_cluster.app_env]
  source     = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version    = "14.2.0"

  project_id   = google_project.app_env.project_id
  cluster_name = google_container_cluster.app_env.name
  location     = var.region
}

resource "local_file" "kubeconfig" {
  content         = module.google_container_cluster_auth.kubeconfig_raw
  filename        = var.kubeconfig_path
  file_permission = "0600"
}
