#!/bin/sh
set -e

VERSION='3.5.2'
URL="https://get.helm.sh/helm-v${VERSION:?}-darwin-amd64.tar.gz"
SHA='68040e9a2f147a92c2f66ce009069826df11f9d1e1c6b78c7457066080ad3229'
SHA_ALGORITHM=256

"${INSTALL_LOCAL_PACKAGE:?}" helm \
  "${VERSION:?}" "${URL:?}" darwin-amd64/helm "${SHA:?}" "${SHA_ALGORITHM:?}"
