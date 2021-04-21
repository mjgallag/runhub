#!/bin/sh
set -e

VERSION='337.0.0'
URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VERSION:?}-darwin-x86_64.tar.gz"
SHA='f9828404af0f166afbaf4d9f00e8c1fab0d3a54b5a7f7cda0e0402712508e522'
SHA_ALGORITHM=256
GCLOUD="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" gcloud \
  "${VERSION:?}" "${URL:?}" google-cloud-sdk/bin/gcloud "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${GCLOUD:?}" "$@"
