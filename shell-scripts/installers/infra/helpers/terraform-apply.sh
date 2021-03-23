#!/bin/sh
set -e

terraform_apply() {
  if ! "${INSTALLERS_DIR:?}/bin/helpers/get-stderr.sh" \
    "${BIN_DIR:?}/terraform.sh" init -upgrade -no-color; then

    if [ "$(< "${BIN_STDERR:?}" tr -d '\n')" = "${LOGIN_ERROR:?}" ]; then
      "${INSTALLERS_DIR:?}/infra/helpers/login/${INFRA:?}.sh"
      terraform_apply
    elif [ "$(< "${BIN_STDERR:?}" tr -d '\n')" = "${BACKEND_ERROR:?}" ]; then
      rm "${APP_ENV_TERRAFORM_DIR:?}/backend.tf"
      rm -r "${APP_ENV_TERRAFORM_DIR:?}/.terraform"
      "${BIN_DIR:?}/terraform.sh" init -upgrade
      "${BIN_DIR:?}/terraform.sh" apply -auto-approve
      "${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"
      "${BIN_DIR:?}/terraform.sh" init -upgrade -force-copy
    else
      cat "${BIN_STDERR:?}" >&2
      exit 1
    fi

  else
    "${BIN_DIR:?}/terraform.sh" apply -auto-approve
  fi
}

"${INSTALLERS_DIR:?}/infra/helpers/generate-main-tf.sh"
"${INSTALLERS_DIR:?}/infra/helpers/generate-backend-tf.sh"
"${BIN_DIR:?}/terraform.sh" version > /dev/null
terraform_apply
