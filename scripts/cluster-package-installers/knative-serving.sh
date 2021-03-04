#!/bin/sh
set -e

SERVNG_VERSION='0.20.1'
NET_ISTIO_VERSION='0.20.0'
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"

"${KUBECTL:?}" apply --filename \
  "https://github.com/knative/serving/releases/download/v${SERVNG_VERSION:?}/serving-crds.yaml"
"${KUBECTL:?}" apply --filename \
  "https://github.com/knative/serving/releases/download/v${SERVNG_VERSION:?}/serving-core.yaml"
"${KUBECTL:?}" apply --filename \
  "https://github.com/knative/net-istio/releases/download/v${NET_ISTIO_VERSION:?}/release.yaml"
"${KUBECTL:?}" patch configmap/config-autoscaler \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"allow-zero-initial-scale":"true"}}'
