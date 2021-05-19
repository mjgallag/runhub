#!/bin/sh
set -e

VERSION='1.19.11'
URL="https://dl.k8s.io/v${VERSION:?}/kubernetes-client-darwin-amd64.tar.gz"
SHA='014f7890bc22d10d15f0dbb0a76e4ab4ce06c35a189b71f99b623749535b7fefc31c9ebc7d312eef7f60bc0971d7d178b694747c367082b1bf070c1b9f6053b4'
SHA_ALGORITHM=512
KUBECTL="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" kubectl \
  "${VERSION:?}" "${URL:?}" kubernetes/client/bin/kubectl "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${KUBECTL:?}" "$@"
