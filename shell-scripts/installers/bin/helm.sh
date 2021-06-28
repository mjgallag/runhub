#!/bin/sh
set -e

VERSION='3.6.1'
URL="https://get.helm.sh/helm-v${VERSION:?}-darwin-amd64.tar.gz"
SHA='f5e49aac89701162871e576ebd32506060e43a470da1fcb4b8e4118dc3512913'
SHA_ALGORITHM=256
HELM="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" helm \
  "${VERSION:?}" "${URL:?}" darwin-amd64/helm "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${HELM:?}" "$@"
