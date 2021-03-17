#!/bin/sh
set -e

VERSION='332.0.0'
URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VERSION:?}-darwin-x86_64.tar.gz"
SHA='1d158a84dfff8f3aa3cacdbbd3fb9cfbea3178728367b20c986760edc1665026'
SHA_ALGORITHM=256

"${INSTALLERS_DIR:?}/bin/helpers/install.sh" gcloud \
  "${VERSION:?}" "${URL:?}" google-cloud-sdk/bin/gcloud "${SHA:?}" "${SHA_ALGORITHM:?}"
