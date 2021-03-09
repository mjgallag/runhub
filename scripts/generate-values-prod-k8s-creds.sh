#!/bin/sh
set -e

APP="${1:?}"
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"

CLUSTER_SERVER="$("${KUBECTL:?}" config view \
  --template '{{ index (index (index .clusters 0) "cluster") "server" }}')"
CLUSTER_CERTIFICATE_AUTHORITY="$("${KUBECTL:?}" config view --raw \
  --template '{{ index (index (index .clusters 0) "cluster") "certificate-authority-data" }}')"
SERVICE_ACCOUNT_TOKEN_SECRET="$("${KUBECTL:?}" get serviceaccount \
  --namespace prod-hello-world deploy --template '{{ index (index .secrets 0) "name" }}')"
SERVICE_ACCOUNT_TOKEN="$("${KUBECTL:?}" get secret \
  --namespace "prod-${APP:?}" "${SERVICE_ACCOUNT_TOKEN_SECRET:?}" \
  --template '{{ print (.data.token | base64decode) }}')"

cat <<EOF > "${BASE_DIR:?}/values-prod-k8s-creds.yaml"
dev:
  release:
    prodKubernetesCredentials:
      clusterServer: ${CLUSTER_SERVER:?}
      clusterCertificateAuthorityData: ${CLUSTER_CERTIFICATE_AUTHORITY:?}
      serviceAccountToken: ${SERVICE_ACCOUNT_TOKEN:?}
EOF
