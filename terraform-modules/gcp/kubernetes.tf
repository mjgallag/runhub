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
    enabled = true
    resource_limits {
      resource_type = "cpu"
      maximum       = 64 * 400
    }
    resource_limits {
      resource_type = "memory"
      maximum       = 240 * 400
    }
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

resource "google_container_node_pool" "main" {
  project    = google_project.app_env.project_id
  name       = "main"
  location   = var.region
  cluster    = google_container_cluster.app_env.name
  node_count = 1
  node_config {
    machine_type = "n1-standard-1"
  }
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
