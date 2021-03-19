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

${VARIABLE_ASSIGNMENTS:?}
}

${OUTPUT_DEFINITIONS:?}
EOF
