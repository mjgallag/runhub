#!/bin/sh
set -e

# shellcheck source=scripts/initialize.sh
. "$(dirname "${0:?}")/scripts/initialize.sh"

APP="${1:?}"
ENV="${2:?}"
PROVIDER="${3}"

if [ "${PROVIDER}" ]; then
  if [ "${PROVIDER:?}" = 'gcp' ]; then
    "${INFRASTRUCTURE_INSTALLERS_DIR:?}/gcp.sh"
  fi
else
  export KUBECONFIG="${USER_HOME_DIR:?}/.kube/config"
fi

if [ "${ENV:?}" = 'dev' ] || [ "${ENV:?}" = 'prod' ]; then
  "${KUBERNETES_INSTALLERS_DIR:?}/istio.sh"
  "${KUBERNETES_INSTALLERS_DIR:?}/cert-manager.sh"
  "${KUBERNETES_INSTALLERS_DIR:?}/knative/serving.sh"
  "${KUBERNETES_INSTALLERS_DIR:?}/knative/net-istio.sh"
fi

if [ "${ENV:?}" = 'dev' ]; then
  "${KUBERNETES_INSTALLERS_DIR:?}/tekton/pipelines.sh"
  "${KUBERNETES_INSTALLERS_DIR:?}/tekton/triggers.sh"
  "${KUBERNETES_INSTALLERS_DIR:?}/tekton/dashboard.sh"
fi

"${KUBERNETES_INSTALLERS_DIR:?}/app.sh" "${APP:?}" "${ENV:?}"

if [ "${ENV:?}" = 'prod' ]; then
  "${WRITE_PROD_K8S_CREDS:?}" "${APP:?}"
fi
