#!/bin/sh
set -e

VERSION='1.9.6'
URL="https://github.com/istio/istio/releases/download/${VERSION:?}/istioctl-${VERSION:?}-osx.tar.gz"
SHA='0db7eafcdca9204622f45a2a408803e95740030c31288e6d6350820df69d7a30'
SHA_ALGORITHM=256
ISTIOCTL="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" istioctl \
  "${VERSION:?}" "${URL:?}" istioctl "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${ISTIOCTL:?}" "$@"
