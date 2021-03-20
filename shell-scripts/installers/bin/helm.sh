#!/bin/sh
set -e

VERSION='3.5.3'
URL="https://get.helm.sh/helm-v${VERSION:?}-darwin-amd64.tar.gz"
SHA='451ad70dfe286e3979c78ecf7074f4749d93644da8aa2cc778e2f969771f1794'
SHA_ALGORITHM=256
HELM="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" helm \
  "${VERSION:?}" "${URL:?}" darwin-amd64/helm "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${HELM:?}" "$@"
