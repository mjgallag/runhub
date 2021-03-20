#!/bin/sh
set -e

TERRAFORM="${INSTALLERS_DIR:?}/bin/terraform.sh"

"${INSTALLERS_DIR:?}/infra/helpers/generate-main-tf.sh"
"${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"

if "${TERRAFORM:?}" init -upgrade; then
  "${TERRAFORM:?}" apply -auto-approve
else
  rm "${APP_ENV_TERRAFORM_DIR:?}/backend.tf"
  rm -r "${APP_ENV_TERRAFORM_DIR:?}/.terraform"
  "${TERRAFORM:?}" init -upgrade
  "${TERRAFORM:?}" apply -auto-approve
  "${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"
  "${TERRAFORM:?}" init -upgrade -force-copy
fi
