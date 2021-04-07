locals {
  container_registry_username = "_json_key_base64"
}

output "container_registry_server" {
  value = local.is_dev ? "${google_artifact_registry_repository.app[0].location}-docker.pkg.dev" : ""
}

output "container_registry_path" {
  value = local.is_dev ? "${google_project.app_env.project_id}/${google_artifact_registry_repository.app[0].repository_id}" : ""
}

output "dev_container_registry_username" {
  value = local.is_dev ? local.container_registry_username : ""
}

output "dev_container_registry_password" {
  value = local.is_dev ? google_service_account_key.dev_container_registry[0].private_key : ""
}

output "prod_container_registry_username" {
  value = local.is_dev ? local.container_registry_username : ""
}

output "prod_container_registry_password" {
  value = local.is_dev ? google_service_account_key.prod_container_registry[0].private_key : ""
}
