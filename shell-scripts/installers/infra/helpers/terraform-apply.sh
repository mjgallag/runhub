#!/bin/sh
set -e

export APP_ENV_TERRAFORM_DIR="${SCRIPT_CONFIG_DIR:?}/app/${APP:?}/${ENV:?}/terraform"
TERRAFORM="$("${INSTALLERS_DIR:?}/bin/terraform.sh")"

mkdir -p "${APP_ENV_TERRAFORM_DIR:?}"
"${INSTALLERS_DIR:?}/infra/helpers/generate-main-tf.sh"

if "${INSTALLERS_DIR:?}/infra/helpers/has-tfstate/${BACKEND_TYPE:?}.sh"; then
  "${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"
  (cd "${APP_ENV_TERRAFORM_DIR:?}" && "${TERRAFORM:?}" init -upgrade)
  (cd "${APP_ENV_TERRAFORM_DIR:?}" && "${TERRAFORM:?}" apply -auto-approve)
else
  (cd "${APP_ENV_TERRAFORM_DIR:?}" && "${TERRAFORM:?}" init -upgrade)
  (cd "${APP_ENV_TERRAFORM_DIR:?}" && "${TERRAFORM:?}" apply -auto-approve)
  "${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"
  (cd "${APP_ENV_TERRAFORM_DIR:?}" && "${TERRAFORM:?}" init -upgrade -force-copy)
fi
