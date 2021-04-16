#!/bin/sh
set -e

VERSION='1.8.5'
URL="https://github.com/istio/istio/releases/download/${VERSION:?}/istioctl-${VERSION:?}-osx.tar.gz"
SHA='24ac10f0b40d1bb8f01531ea16a25f2c2c29140e95d64d2123b5cba3b99a7e7e'
SHA_ALGORITHM=256
ISTIOCTL="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" istioctl \
  "${VERSION:?}" "${URL:?}" istioctl "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${ISTIOCTL:?}" "$@"
