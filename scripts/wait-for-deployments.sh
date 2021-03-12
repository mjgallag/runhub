#!/bin/sh
set -e

NAMESPACE="${1:?}"
KUBECTL="$("${BINARY_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"
DEPLOYMENTS="$("${KUBECTL:?}" get --namespace "${NAMESPACE:?}" deployments --output name)"

for DEPLOYMENT in ${DEPLOYMENTS:?}; do
  "${KUBECTL:?}" rollout status --namespace "${NAMESPACE:?}" "${DEPLOYMENT:?}"
done
