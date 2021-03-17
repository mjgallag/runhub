#!/bin/sh
set -e

VALUES_DEV__PROD_K8S_CREDS_YAML="${SCRIPT_DIR:?}/values-dev--prod-k8s-creds.yaml"
KUBECTL="$("${INSTALLERS_DIR:?}/bin/kubectl.sh")"
HELM="$("${INSTALLERS_DIR:?}/bin/helm.sh")"

set -- upgrade --install --atomic "${APP:?}" "${SCRIPT_DIR:?}"/helm-charts/runhub-app \
  --namespace "${ENV:?}-${APP:?}" --create-namespace \
  --set "global.env.${ENV:?}=true" \
  --values "${SCRIPT_DIR:?}/values-shared.yaml" \
  --values "${SCRIPT_DIR:?}/values-${ENV:?}.yaml"

if [ "${ENV:?}" = 'dev' ] && [ -f "${VALUES_DEV__PROD_K8S_CREDS_YAML:?}" ]; then
  set -- "$@" --values "${VALUES_DEV__PROD_K8S_CREDS_YAML:?}"

  if "${KUBECTL:?}" get namespace "prod-${APP:?}"; then
    CLUSTER_SERVER_INTERNAL_IP="$("${KUBECTL:?}" get service --namespace default kubernetes \
      --output jsonpath='{ .spec.clusterIP }')"

    set -- "$@" --set \
      "dev.release.prodKubernetesCredentials.clusterServer=https://${CLUSTER_SERVER_INTERNAL_IP:?}"
  fi

fi

"${HELM:?}" "$@"

if [ "${ENV:?}" = 'prod' ]; then
  CLUSTER_SERVER="$("${KUBECTL:?}" config view --output jsonpath='{ .clusters[0].cluster.server }')"
  CLUSTER_CERTIFICATE_AUTHORITY="$("${KUBECTL:?}" config view --raw \
    --output jsonpath='{ .clusters[0].cluster.certificate-authority-data }')"
  SERVICE_ACCOUNT_TOKEN_SECRET="$("${KUBECTL:?}" get serviceaccount \
    --namespace "prod-${APP:?}" deploy --output jsonpath='{ .secrets[0].name }')"
  SERVICE_ACCOUNT_TOKEN="$("${KUBECTL:?}" get secret \
    --namespace "prod-${APP:?}" "${SERVICE_ACCOUNT_TOKEN_SECRET:?}" \
    --output go-template='{{ base64decode .data.token }}')"

  cat <<EOF > "${VALUES_DEV__PROD_K8S_CREDS_YAML:?}"
dev:
  release:
    prodKubernetesCredentials:
      clusterServer: ${CLUSTER_SERVER:?}
      clusterCertificateAuthorityData: ${CLUSTER_CERTIFICATE_AUTHORITY:?}
      serviceAccountToken: ${SERVICE_ACCOUNT_TOKEN:?}
EOF
fi
