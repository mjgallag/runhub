#!/bin/sh
set -e

cat <<EOF > "${APP_ENV_TERRAFORM_DIR:?}/main.tf"
module "${INFRA:?}" {
  source = "${SCRIPT_DIR:?}/terraform-modules/${INFRA:?}"
  
  app = "${APP:?}"
  env = "${ENV:?}"
}
EOF
