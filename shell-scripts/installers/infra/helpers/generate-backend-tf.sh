#!/bin/sh
set -e

cat <<EOF > "${APP_ENV_TERRAFORM_DIR:?}/backend.tf"
terraform {
  backend "${BACKEND_TYPE:?}" {
    bucket  = "${ENV:?}-${APP:?}-terraform-state"
  }
}
EOF
