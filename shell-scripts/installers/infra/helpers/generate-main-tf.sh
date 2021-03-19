#!/bin/sh
set -e

cat <<EOF > "${APP_ENV_TERRAFORM_DIR:?}/main.tf"
${VARIABLE_DEFINITIONS:?}

module app_env {
  source = "${SCRIPT_DIR:?}/terraform-modules/${INFRA:?}"
  
  app = "${APP:?}"
  env = "${ENV:?}"

${VARIABLE_ASSIGNMENTS:?}
}

${OUTPUT_DEFINITIONS:?}
EOF
