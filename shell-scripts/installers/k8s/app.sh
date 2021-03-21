#!/bin/sh
set -e

VALUES_DEV__PROD_K8S_CREDS_YAML="${SCRIPT_DIR:?}/values-dev--prod-k8s-creds.yaml"

set -- upgrade --install --atomic "${APP:?}" "${SCRIPT_DIR:?}"/helm-charts/runhub-app \
  --namespace "${ENV:?}-${APP:?}" --create-namespace \
  --set "global.env.${ENV:?}=true" \
  --values "${SCRIPT_DIR:?}/values-shared.yaml" \
  --values "${SCRIPT_DIR:?}/values-${ENV:?}.yaml"

if [ "${ENV:?}" = 'dev' ] && [ -f "${VALUES_DEV__PROD_K8S_CREDS_YAML:?}" ]; then
  set -- "$@" --values "${VALUES_DEV__PROD_K8S_CREDS_YAML:?}"
fi

"${BIN_DIR:?}/helm.sh" "$@"

if [ "${ENV:?}" = 'prod' ]; then
  CURRENT_CONTEXT="$("${BIN_DIR:?}/kubectl.sh" config view \
    --output jsonpath='{ .current-context }')"
  CLUSTER="$("${BIN_DIR:?}/kubectl.sh" config view \
    --output jsonpath='{ .contexts[?(@.name=="'"${CURRENT_CONTEXT:?}"'")].name }')"

  if "${BIN_DIR:?}/kubectl.sh" get namespace "dev-${APP:?}"; then
    CLUSTER_SERVER="https://$("${BIN_DIR:?}/kubectl.sh" get service \
      --namespace default kubernetes --output jsonpath='{ .spec.clusterIP }')"
  else
    CLUSTER_SERVER="$("${BIN_DIR:?}/kubectl.sh" config view \
      --output jsonpath='{ .clusters[?(@.name=="'"${CLUSTER:?}"'")].cluster.server }')"
  fi

  CLUSTER_CERTIFICATE_AUTHORITY="$("${BIN_DIR:?}/kubectl.sh" config view --raw --output \
    jsonpath='{ .clusters[?(@.name=="'"${CLUSTER:?}"'")].cluster.certificate-authority-data }')"
  SERVICE_ACCOUNT_TOKEN_SECRET="$("${BIN_DIR:?}/kubectl.sh" get serviceaccount \
    --namespace "prod-${APP:?}" deploy --output jsonpath='{ .secrets[0].name }')"
  SERVICE_ACCOUNT_TOKEN="$("${BIN_DIR:?}/kubectl.sh" get secret \
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
