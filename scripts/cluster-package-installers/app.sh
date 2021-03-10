#!/bin/sh
set -e

APP="${1:?}"
ENV="${2:?}"
HELM="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/helm.sh")"

set -- upgrade --install --atomic "${APP:?}" "${BASE_DIR:?}"/charts/runhub-app \
  --namespace "${ENV:?}-${APP:?}" --create-namespace \
  --set "global.env.${ENV:?}=true" \
  --values "${BASE_DIR:?}/values-shared.yaml" \
  --values "${BASE_DIR:?}/values-${ENV:?}.yaml"

if [ -f "${BASE_DIR:?}/values-dev--prod-k8s-creds.yaml" ]; then
  "${HELM:?}" "$@" --values "${BASE_DIR:?}/values-dev--prod-k8s-creds.yaml"
else
  "${HELM:?}" "$@"
fi
