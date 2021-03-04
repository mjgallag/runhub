#!/bin/sh
set -e

VERSION='0.20.0'
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"

"${KUBECTL:?}" apply --filename \
  "https://github.com/knative-sandbox/net-istio/releases/download/v${VERSION:?}/net-istio.yaml"
