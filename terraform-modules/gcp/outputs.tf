locals {
  container_registry_username = "_json_key_base64"
}

output "container_registry_server" {
  value = "${google_artifact_registry_repository.container_registry[0].location}-docker.pkg.dev"
}

output "container_registry_path" {
  value = "${google_project.app_env.project_id}/${google_artifact_registry_repository.container_registry[0].repository_id}"
}

output "dev_container_registry_username" {
  value = local.container_registry_username
}

output "dev_container_registry_password" {
  value = google_service_account_key.dev_container_registry[0].private_key
}

output "prod_container_registry_username" {
  value = local.container_registry_username
}

output "prod_container_registry_password" {
  value = google_service_account_key.prod_container_registry[0].private_key
}
