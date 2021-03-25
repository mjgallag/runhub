#!/bin/sh
set -e

cat <<EOF > "${APP_ENV_TERRAFORM_DIR:?}/main.tf"
variable "env" {
  type = string
  validation {
    condition     = var.env == "prod" || var.env == "dev"
    error_message = "The env value must be either 'prod' or 'dev'."
  }
  default = "${ENV:?}"
}

${VARIABLE_DEFINITIONS:?}

module app_env {
  source = "${SCRIPT_DIR:?}/terraform-modules/${INFRA:?}"

  app = "${APP:?}"
  env = var.env
  kubeconfig_path = "${HOME:?}/.kube/config"

${VARIABLE_ASSIGNMENTS:?}
}

output "container_registry_server" {
  value = module.app_env.container_registry_server
}

output "container_registry_path" {
  value = module.app_env.container_registry_path
}

output "dev_container_registry_username" {
  value = module.app_env.dev_container_registry_username
}

output "dev_container_registry_password" {
  value     = module.app_env.dev_container_registry_password
  sensitive = true
}

output "prod_container_registry_username" {
  value = module.app_env.prod_container_registry_username
}

output "prod_container_registry_password" {
  value     = module.app_env.prod_container_registry_password
  sensitive = true
}
EOF
