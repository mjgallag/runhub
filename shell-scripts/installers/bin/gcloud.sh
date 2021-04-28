#!/bin/sh
set -e

VERSION='338.0.0'
URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VERSION:?}-darwin-x86_64.tar.gz"
SHA='cff5641001846e50632b2ac30138d94b6df7d5254a3c44cad978df0f81f1f117'
SHA_ALGORITHM=256
GCLOUD="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" gcloud \
  "${VERSION:?}" "${URL:?}" google-cloud-sdk/bin/gcloud "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${GCLOUD:?}" "$@"
