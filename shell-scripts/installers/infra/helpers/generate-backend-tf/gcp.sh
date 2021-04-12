#!/bin/sh
set -e

cat <<EOF > "${APP_ENV_TERRAFORM_DIR:?}/backend.tf"
terraform {
  backend "gcs" {
    bucket  = "${ENV:?}-${APP:?}-terraform-state"
  }
}
EOF
