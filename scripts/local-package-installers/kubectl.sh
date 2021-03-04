#!/bin/sh
set -e

VERSION='1.17.17'
URL="https://dl.k8s.io/v${VERSION:?}/kubernetes-client-darwin-amd64.tar.gz"
SHA='3d2589761b7172896ba60fedd413b7e59e2b16262eac21e743c23acd9d2b73e42186cdb8f7b64357ee42064559d17757e37c8a36682730f16229945ffde27626'
SHA_ALGORITHM=512

"${INSTALL_LOCAL_PACKAGE:?}" kubectl "${VERSION:?}" "${URL:?}" kubernetes/client/bin/kubectl "${SHA:?}" "${SHA_ALGORITHM:?}"
