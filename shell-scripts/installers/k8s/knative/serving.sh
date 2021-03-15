#!/bin/sh
set -e

VERSION='0.21.0'
KUBECTL="$("${INSTALLERS_DIR:?}/bin/kubectl.sh")"

"${KUBECTL:?}" apply --filename \
  "https://github.com/knative/serving/releases/download/v${VERSION:?}/serving-crds.yaml"
"${KUBECTL:?}" apply --filename \
  "https://github.com/knative/serving/releases/download/v${VERSION:?}/serving-core.yaml"
"${KUBECTL:?}" patch configmap/config-autoscaler \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"allow-zero-initial-scale":"true"}}'

"${INSTALLERS_DIR:?}/k8s/helpers/wait-for-deployments.sh" knative-serving
