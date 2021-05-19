#!/bin/sh
set -e

VERSION='0.15.4'
URL="https://releases.hashicorp.com/terraform/${VERSION:?}/terraform_${VERSION:?}_darwin_amd64.zip"
SHA='c7e413ad9d00a5ba177a32b0d46ff177239bd53a1aab67e7c5efad2e1e25978e'
SHA_ALGORITHM=256
TERRAFORM="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" terraform \
  "${VERSION:?}" "${URL:?}" terraform "${SHA:?}" "${SHA_ALGORITHM:?}")"
export TF_PLUGIN_CACHE_DIR="${HOME:?}/.terraform.d/plugin-cache"

mkdir -p "${TF_PLUGIN_CACHE_DIR:?}"
"${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" "$@"
