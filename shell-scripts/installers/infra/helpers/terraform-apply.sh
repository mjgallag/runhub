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
      rm "${APP_ENV_TERRAFORM_DIR:?}/.terraform/terraform.tfstate"
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

if [ "${ENV:?}" = 'dev' ]; then
  for VALUES_ENV in 'dev' 'prod'; do
    cat <<EOF >> "${APP_ENV_HELM_DIR:?}/values-${VALUES_ENV:?}-infra.yaml"
global:
  containerRegistryCredentials:
    server: $("${BIN_DIR:?}/terraform.sh" output -raw container_registry_server)
    path: $("${BIN_DIR:?}/terraform.sh" output -raw container_registry_path)
    username: $("${BIN_DIR:?}/terraform.sh" output -raw ${VALUES_ENV:?}_container_registry_username)
    password: $("${BIN_DIR:?}/terraform.sh" output -raw ${VALUES_ENV:?}_container_registry_password)
EOF
  done
fi
