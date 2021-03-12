#!/bin/sh
set -e

VERSION='1.18.16'
URL="https://dl.k8s.io/v${VERSION:?}/kubernetes-client-darwin-amd64.tar.gz"
SHA='9070e8a26c975c41634e564597e7739fde5d550489e7432c4f90a2ebb8d31f36a4ef47ede793ad555545d952dee390cf2c651406e42d7404c3ea73a4efa36dff'
SHA_ALGORITHM=512

"${INSTALL_BINARY_PACKAGE:?}" kubectl \
  "${VERSION:?}" "${URL:?}" kubernetes/client/bin/kubectl "${SHA:?}" "${SHA_ALGORITHM:?}"
