#!/bin/sh
set -e

VERSION='0.23.1'

"${BIN_DIR:?}/kubectl.sh" apply --filename \
  "https://github.com/knative-sandbox/net-istio/releases/download/v${VERSION:?}/net-istio.yaml"
"${INSTALLERS_DIR:?}/k8s/helpers/wait-for-deployments.sh" knative-serving
