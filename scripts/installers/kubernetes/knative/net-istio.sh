#!/bin/sh
set -e

VERSION='0.21.0'
KUBECTL="$("${BINARY_INSTALLERS_DIR:?}/kubectl.sh")"

"${KUBECTL:?}" apply --filename \
  "https://github.com/knative-sandbox/net-istio/releases/download/v${VERSION:?}/net-istio.yaml"

"${WAIT_FOR_DEPLOYMENTS:?}" knative-serving
