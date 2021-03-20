#!/bin/sh
set -e

NAMESPACE="${1:?}"
DEPLOYMENTS="$("${BIN_DIR:?}/kubectl.sh" get --namespace "${NAMESPACE:?}" deployments \
  --output name)"

for DEPLOYMENT in ${DEPLOYMENTS:?}; do
  "${BIN_DIR:?}/kubectl.sh" rollout status --namespace "${NAMESPACE:?}" "${DEPLOYMENT:?}"
done
