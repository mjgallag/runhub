#!/bin/sh
set -e

VERSION='3.5.4'
URL="https://get.helm.sh/helm-v${VERSION:?}-darwin-amd64.tar.gz"
SHA='072c40c743d30efdb8231ca03bab55caee7935e52175e42271a0c3bc37ec0b7b'
SHA_ALGORITHM=256
HELM="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" helm \
  "${VERSION:?}" "${URL:?}" darwin-amd64/helm "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${HELM:?}" "$@"
