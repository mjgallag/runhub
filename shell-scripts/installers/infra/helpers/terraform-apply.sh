#!/bin/sh
set -e

TERRAFORM="${INSTALLERS_DIR:?}/bin/terraform.sh"

"${INSTALLERS_DIR:?}/infra/helpers/generate-main-tf.sh"

if "${INSTALLERS_DIR:?}/infra/helpers/has-tfstate/${BACKEND_TYPE:?}.sh"; then
  "${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"
  "${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" init -upgrade
  "${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" apply -auto-approve
else
  "${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" init -upgrade
  "${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" apply -auto-approve
  "${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"
  "${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" init -upgrade -force-copy
fi
