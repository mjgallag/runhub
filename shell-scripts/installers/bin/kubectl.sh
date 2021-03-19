#!/bin/sh
set -e

VERSION='1.18.17'
URL="https://dl.k8s.io/v${VERSION:?}/kubernetes-client-darwin-amd64.tar.gz"
SHA='cff748a737c04b75d112386acb67a47d4589785f0b95643b8e77771a163bb52f5d6c5a979ca78adbc533255a923d919fdd5e83f12705a517769c2aed677ffae7'
SHA_ALGORITHM=512

"${INSTALLERS_DIR:?}/bin/helpers/install.sh" kubectl \
  "${VERSION:?}" "${URL:?}" kubernetes/client/bin/kubectl "${SHA:?}" "${SHA_ALGORITHM:?}"
