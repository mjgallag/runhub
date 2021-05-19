#!/bin/sh
set -e

VERSION='341.0.0'
URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VERSION:?}-darwin-x86_64.tar.gz"
SHA='e7c13e1159b9a9652b2fb96b776f73b58f145fb53e0d4c13c4cba1a6dd01b800'
SHA_ALGORITHM=256
GCLOUD="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" gcloud \
  "${VERSION:?}" "${URL:?}" google-cloud-sdk/bin/gcloud "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${GCLOUD:?}" "$@"
