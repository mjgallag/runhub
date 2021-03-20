#!/bin/sh
set -e

VERSION='0.14.8'
URL="https://releases.hashicorp.com/terraform/${VERSION:?}/terraform_${VERSION:?}_darwin_amd64.zip"
SHA='30115a2ee5f61178527089d8e5da20053927b364b08dc7aee6894a162ccbd793'
SHA_ALGORITHM=256
TERRAFORM="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" terraform \
  "${VERSION:?}" "${URL:?}" terraform "${SHA:?}" "${SHA_ALGORITHM:?}")"
export TF_PLUGIN_CACHE_DIR="${HOME:?}/.terraform.d/plugin-cache"

mkdir -p "${TF_PLUGIN_CACHE_DIR:?}"
"${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" "$@"
