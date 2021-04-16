#!/bin/sh
set -e

VERSION='1.18.18'
URL="https://dl.k8s.io/v${VERSION:?}/kubernetes-client-darwin-amd64.tar.gz"
SHA='18ad76c92e7d9b8180622615965bbafe84ef04d56eef1d5e41a5e00ef92bdc309486ea954e9a38bc0c91c4e0449c46c6c95a79f0a9b8c96d665ea355e1e2e747'
SHA_ALGORITHM=512
KUBECTL="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" kubectl \
  "${VERSION:?}" "${URL:?}" kubernetes/client/bin/kubectl "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${KUBECTL:?}" "$@"
