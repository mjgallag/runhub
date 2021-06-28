#!/bin/sh
set -e

VERSION='1.19.12'
URL="https://dl.k8s.io/v${VERSION:?}/kubernetes-client-darwin-amd64.tar.gz"
SHA='6cdc19fb159199cee0b222556666e5e358ba6469099d47a354f35cc510c6f4344440c9712ee7b91d50251d1a0e304f7ad830e423ae1457ce7ea23463755b4fad'
SHA_ALGORITHM=512
KUBECTL="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" kubectl \
  "${VERSION:?}" "${URL:?}" kubernetes/client/bin/kubectl "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${KUBECTL:?}" "$@"
