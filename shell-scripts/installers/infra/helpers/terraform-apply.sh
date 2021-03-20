#!/bin/sh
set -e

"${INSTALLERS_DIR:?}/infra/helpers/generate-main-tf.sh"
"${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"

if "${BIN_DIR:?}/terraform.sh" init -upgrade; then
  "${BIN_DIR:?}/terraform.sh" apply -auto-approve
else
  rm "${APP_ENV_TERRAFORM_DIR:?}/backend.tf"
  rm -r "${APP_ENV_TERRAFORM_DIR:?}/.terraform"
  "${BIN_DIR:?}/terraform.sh" init -upgrade
  "${BIN_DIR:?}/terraform.sh" apply -auto-approve
  "${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"
  "${BIN_DIR:?}/terraform.sh" init -upgrade -force-copy
fi
