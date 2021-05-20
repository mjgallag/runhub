#!/bin/sh
set -e

VERSION='1.9.5'
URL="https://github.com/istio/istio/releases/download/${VERSION:?}/istioctl-${VERSION:?}-osx.tar.gz"
SHA='8b830b5c0854bdee727f44bf36d7505a834eeff4d6047dbd662c86d02acabf05'
SHA_ALGORITHM=256
ISTIOCTL="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" istioctl \
  "${VERSION:?}" "${URL:?}" istioctl "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${ISTIOCTL:?}" "$@"
