#!/bin/sh
set -e

APP="${1:?}"
ENV="${2:?}"
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"
HELM="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/helm.sh")"

set -- upgrade --install --atomic "${APP:?}" "${BASE_DIR:?}"/charts/runhub-app \
  --namespace "${ENV:?}-${APP:?}" --create-namespace \
  --set "global.env.${ENV:?}=true" \
  --values "${BASE_DIR:?}/values-shared.yaml" \
  --values "${BASE_DIR:?}/values-${ENV:?}.yaml"

if [ "${ENV:?}" = "${ENV_DEV:?}" ] && [ -f "${BASE_DIR:?}/values-dev--prod-k8s-creds.yaml" ]; then
  set -- "$@" --values "${BASE_DIR:?}/values-dev--prod-k8s-creds.yaml"

  if "${KUBECTL:?}" get namespace "prod-${APP:?}"; then
    CLUSTER_SERVER_INTERNAL_IP="$("${KUBECTL:?}" get service --namespace default kubernetes \
      --output jsonpath='{ .spec.clusterIP }')"

    set -- "$@" --set \
      "dev.release.prodKubernetesCredentials.clusterServer=https://${CLUSTER_SERVER_INTERNAL_IP:?}"
  fi

fi

"${HELM:?}" "$@"
