resource "google_project_service" "artifact_registry" {
  count   = local.is_dev ? 1 : 0
  project = google_project.app_env.project_id
  service = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "container_registry" {
  count         = local.is_dev ? 1 : 0
  depends_on    = [google_project_service.artifact_registry]
  provider      = google-beta
  project       = google_project.app_env.project_id
  repository_id = "app"
  location      = var.region
  format        = "DOCKER"
}

resource "google_service_account" "dev_container_registry" {
  count      = local.is_dev ? 1 : 0
  project    = google_project.app_env.project_id
  account_id = "dev-container-registry"
}

resource "google_service_account" "prod_container_registry" {
  count      = local.is_dev ? 1 : 0
  project    = google_project.app_env.project_id
  account_id = "prod-container-registry"
}

resource "google_artifact_registry_repository_iam_member" "dev_container_registry_writer" {
  count      = local.is_dev ? 1 : 0
  provider   = google-beta
  project    = google_project.app_env.project_id
  repository = google_artifact_registry_repository.container_registry[0].name
  location   = var.region
  member     = "serviceAccount:${google_service_account.dev_container_registry[0].email}"
  role       = "roles/artifactregistry.writer"
}

resource "google_artifact_registry_repository_iam_member" "prod_container_registry_reader" {
  count      = local.is_dev ? 1 : 0
  provider   = google-beta
  project    = google_project.app_env.project_id
  repository = google_artifact_registry_repository.container_registry[0].name
  location   = var.region
  member     = "serviceAccount:${google_service_account.prod_container_registry[0].email}"
  role       = "roles/artifactregistry.reader"
}

resource "google_service_account_key" "dev_container_registry" {
  count              = local.is_dev ? 1 : 0
  service_account_id = google_service_account.dev_container_registry[0].name
}

resource "google_service_account_key" "prod_container_registry" {
  count              = local.is_dev ? 1 : 0
  service_account_id = google_service_account.prod_container_registry[0].name
}
