#!/bin/sh
set -e

VERSION='339.0.0'
URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VERSION:?}-darwin-x86_64.tar.gz"
SHA='d32bd4d0677bc3a2dcf5cf2f090c0864b5beea4606b5924a216a3980d1d166f5'
SHA_ALGORITHM=256
GCLOUD="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" gcloud \
  "${VERSION:?}" "${URL:?}" google-cloud-sdk/bin/gcloud "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${GCLOUD:?}" "$@"
