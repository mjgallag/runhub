#!/bin/sh
set -e

VERSION='1.8.6'
URL="https://github.com/istio/istio/releases/download/${VERSION:?}/istioctl-${VERSION:?}-osx.tar.gz"
SHA='eb89f18fe925d3af2e9a1e9e91269cfbe6bda5d8b1bcffd21f82dc1d244f56cb'
SHA_ALGORITHM=256
ISTIOCTL="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" istioctl \
  "${VERSION:?}" "${URL:?}" istioctl "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${ISTIOCTL:?}" "$@"
