#!/bin/sh
set -e

VERSION='0.20.1'
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"

"${KUBECTL:?}" apply --filename \
  "https://github.com/knative/serving/releases/download/v${VERSION:?}/serving-crds.yaml"
"${KUBECTL:?}" apply --filename \
  "https://github.com/knative/serving/releases/download/v${VERSION:?}/serving-core.yaml"
"${KUBECTL:?}" patch configmap/config-autoscaler \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"allow-zero-initial-scale":"true"}}'

"${SCRIPTS_DIR:?}/wait-for-deployments.sh" knative-serving
