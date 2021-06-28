#!/bin/sh
set -e

VERSION='346.0.0'
URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VERSION:?}-darwin-x86_64.tar.gz"
SHA='632164280208c050f015c9d04fa805c05478e80518a0fe667b413df55ab926ee'
SHA_ALGORITHM=256
GCLOUD="$("${INSTALLERS_DIR:?}/bin/helpers/install.sh" gcloud \
  "${VERSION:?}" "${URL:?}" google-cloud-sdk/bin/gcloud "${SHA:?}" "${SHA_ALGORITHM:?}")"

"${GCLOUD:?}" "$@"
