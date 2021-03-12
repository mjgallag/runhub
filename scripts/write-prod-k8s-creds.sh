#!/bin/sh
set -e

APP="${1:?}"
KUBECTL="$("${BINARY_INSTALLERS_DIR:?}/kubectl.sh")"

CLUSTER_SERVER="$("${KUBECTL:?}" config view --output jsonpath='{ .clusters[0].cluster.server }')"
CLUSTER_CERTIFICATE_AUTHORITY="$("${KUBECTL:?}" config view --raw \
  --output jsonpath='{ .clusters[0].cluster.certificate-authority-data }')"
SERVICE_ACCOUNT_TOKEN_SECRET="$("${KUBECTL:?}" get serviceaccount \
  --namespace "prod-${APP:?}" deploy --output jsonpath='{ .secrets[0].name }')"
SERVICE_ACCOUNT_TOKEN="$("${KUBECTL:?}" get secret \
  --namespace "prod-${APP:?}" "${SERVICE_ACCOUNT_TOKEN_SECRET:?}" \
  --output go-template='{{ base64decode .data.token }}')"

cat <<EOF > "${BASE_DIR:?}/values-dev--prod-k8s-creds.yaml"
dev:
  release:
    prodKubernetesCredentials:
      clusterServer: ${CLUSTER_SERVER:?}
      clusterCertificateAuthorityData: ${CLUSTER_CERTIFICATE_AUTHORITY:?}
      serviceAccountToken: ${SERVICE_ACCOUNT_TOKEN:?}
EOF
