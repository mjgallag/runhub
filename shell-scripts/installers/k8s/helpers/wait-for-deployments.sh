#!/bin/sh
set -e

NAMESPACE="${1:?}"
KUBECTL="$("${INSTALLERS_DIR:?}/bin/kubectl.sh")"
DEPLOYMENTS="$("${KUBECTL:?}" get --namespace "${NAMESPACE:?}" deployments --output name)"

for DEPLOYMENT in ${DEPLOYMENTS:?}; do
  "${KUBECTL:?}" rollout status --namespace "${NAMESPACE:?}" "${DEPLOYMENT:?}"
done
