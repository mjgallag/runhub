#!/bin/sh
set -e

VERSION='0.21.0'
KUBECTL="${INSTALLERS_DIR:?}/bin/kubectl.sh"

"${KUBECTL:?}" apply --filename \
  "https://github.com/knative-sandbox/net-istio/releases/download/v${VERSION:?}/net-istio.yaml"

"${INSTALLERS_DIR:?}/k8s/helpers/wait-for-deployments.sh" knative-serving
