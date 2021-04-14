#!/bin/sh
set -e

VERSION='0.15.0'
URL="https://releases.hashicorp.com/terraform/${VERSION:?}/terraform_${VERSION:?}_darwin_amd64.zip"
SHA='96537262e38008a421d329ce51c1bc2a1926f0b4e68270c92a81a8a42fa2c513'
SHA_ALGORITHM=256
TERRAFORM="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" terraform \
  "${VERSION:?}" "${URL:?}" terraform "${SHA:?}" "${SHA_ALGORITHM:?}")"
export TF_PLUGIN_CACHE_DIR="${HOME:?}/.terraform.d/plugin-cache"

mkdir -p "${TF_PLUGIN_CACHE_DIR:?}"
"${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" "$@"
