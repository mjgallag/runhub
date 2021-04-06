#!/bin/sh
set -e

VERSION='1.8.4'
URL="https://github.com/istio/istio/releases/download/${VERSION:?}/istioctl-${VERSION:?}-osx.tar.gz"
SHA='499c0d4206d45a030c22c4f141cfeb54b6d23e58807e07d9ab610a21fb576f8e'
SHA_ALGORITHM=256
ISTIOCTL="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" istioctl \
  "${VERSION:?}" "${URL:?}" istioctl "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${ISTIOCTL:?}" "$@"
