#!/bin/sh
set -e

TERRAFORM="${INSTALLERS_DIR:?}/bin/terraform.sh"

"${INSTALLERS_DIR:?}/infra/helpers/generate-main-tf.sh"
"${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"

if "${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" init -upgrade; then
  "${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" apply -auto-approve
else
  rm "${APP_ENV_TERRAFORM_DIR:?}/backend.tf"
  rm -r "${APP_ENV_TERRAFORM_DIR:?}/.terraform"
  "${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" init -upgrade
  "${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" apply -auto-approve
  "${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"
  "${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" init -upgrade -force-copy
fi
