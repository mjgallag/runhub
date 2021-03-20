#!/bin/sh
set -e

VERSION='0.21.0'

"${BIN_DIR:?}/kubectl.sh" apply --filename \
  "https://github.com/knative/serving/releases/download/v${VERSION:?}/serving-crds.yaml"
"${BIN_DIR:?}/kubectl.sh" apply --filename \
  "https://github.com/knative/serving/releases/download/v${VERSION:?}/serving-core.yaml"
"${BIN_DIR:?}/kubectl.sh" patch configmap/config-autoscaler \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"allow-zero-initial-scale":"true"}}'

"${INSTALLERS_DIR:?}/k8s/helpers/wait-for-deployments.sh" knative-serving
