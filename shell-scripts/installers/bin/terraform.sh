#!/bin/sh
set -e

VERSION='0.15.1'
URL="https://releases.hashicorp.com/terraform/${VERSION:?}/terraform_${VERSION:?}_darwin_amd64.zip"
SHA='dd7220e6a76e4c9555576c0500bea94c6a5cb65f286b3e74e8ea7cc34bbce5be'
SHA_ALGORITHM=256
TERRAFORM="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" terraform \
  "${VERSION:?}" "${URL:?}" terraform "${SHA:?}" "${SHA_ALGORITHM:?}")"
export TF_PLUGIN_CACHE_DIR="${HOME:?}/.terraform.d/plugin-cache"

mkdir -p "${TF_PLUGIN_CACHE_DIR:?}"
"${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" "$@"
