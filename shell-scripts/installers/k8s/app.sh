#!/bin/sh
set -e

set -- upgrade --install --atomic \
  --namespace "${ENV:?}-${APP:?}" --create-namespace \
  "${APP:?}" "${SCRIPT_DIR:?}"/helm-charts/runhub --set "global.env.${ENV:?}=true"

for FROM_ENV in 'dev' 'prod'; do
  VALUES_ENV_FROM_ENV="${GENERATED_CONFIG_DIR:?}/values-${ENV:?}-from-${FROM_ENV:?}.yaml"

  if [ -f "${VALUES_ENV_FROM_ENV:?}" ]; then
    set -- "$@" --values "${VALUES_ENV_FROM_ENV:?}"
  fi
done

for VALUES_ENV in 'shared' "${ENV:?}"; do
  ENV_VALUES="${CONFIG_DIR:?}/values-${VALUES_ENV:?}.yaml"

  if [ -f "${ENV_VALUES:?}" ]; then
    set -- "$@" --values "${ENV_VALUES:?}"
  fi
done

"${BIN_DIR:?}/helm.sh" "$@"

if [ "${ENV:?}" = 'prod' ]; then
  CURRENT_CONTEXT="$("${BIN_DIR:?}/kubectl.sh" config view \
    --output jsonpath='{ .current-context }')"
  CLUSTER="$("${BIN_DIR:?}/kubectl.sh" config view \
    --output jsonpath='{ .contexts[?(@.name=="'"${CURRENT_CONTEXT:?}"'")].name }')"

  if "${BIN_DIR:?}/kubectl.sh" get namespace "dev-${APP:?}" 2> /dev/null; then
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

  cat <<EOF >> "${GENERATED_CONFIG_DIR:?}/values-dev-from-${ENV:?}.yaml"
dev:
  release:
    prodKubernetesCredentials:
      clusterServer: ${CLUSTER_SERVER:?}
      clusterCertificateAuthorityData: ${CLUSTER_CERTIFICATE_AUTHORITY:?}
      serviceAccountToken: ${SERVICE_ACCOUNT_TOKEN:?}
EOF
fi
