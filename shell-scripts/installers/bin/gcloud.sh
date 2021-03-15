#!/bin/sh
set -e

VERSION='331.0.0'
URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VERSION:?}-darwin-x86_64.tar.gz"
SHA='32c7b961f4c3d18f772a8900c9bc1300e7f81c0c05d71f93b770a222f00490ba'
SHA_ALGORITHM=256

"${INSTALLERS_DIR:?}/bin/helpers/install.sh" gcloud \
  "${VERSION:?}" "${URL:?}" google-cloud-sdk/bin/gcloud "${SHA:?}" "${SHA_ALGORITHM:?}"
