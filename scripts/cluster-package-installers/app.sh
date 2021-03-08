#!/bin/sh
set -e

ENVIRONMENT="${1:?}"
APP="${2:?}"
HELM="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/helm.sh")"

"${HELM:?}" upgrade --install --atomic "${APP:?}" "${BASE_DIR:?}"/charts/runhub-app \
  --namespace "${ENVIRONMENT:?}-${APP:?}" --create-namespace \
  --set "global.environment.${ENVIRONMENT:?}=true" \
  --values "${BASE_DIR:?}"/values.yaml
