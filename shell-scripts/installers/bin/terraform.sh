#!/bin/sh
set -e

VERSION='0.14.9'
URL="https://releases.hashicorp.com/terraform/${VERSION:?}/terraform_${VERSION:?}_darwin_amd64.zip"
SHA='96d0b1c807415ba295a70e8afed04e233778673103587f321164ebb96be123d8'
SHA_ALGORITHM=256
TERRAFORM="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" terraform \
  "${VERSION:?}" "${URL:?}" terraform "${SHA:?}" "${SHA_ALGORITHM:?}")"
export TF_PLUGIN_CACHE_DIR="${HOME:?}/.terraform.d/plugin-cache"

mkdir -p "${TF_PLUGIN_CACHE_DIR:?}"
"${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" "$@"
