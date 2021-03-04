#!/bin/sh
set -e

# shellcheck source=scripts/initialize.sh
. "$(dirname "${0:?}")/scripts/initialize.sh"

ENVIRONMENT="${1:?}"
APP="${2:?}"
HELM="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/helm.sh")"

if [ "${ENVIRONMENT:?}" = 'dev' ] || [ "${ENVIRONMENT:?}" = 'prod' ]; then
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/istio.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/cert-manager.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/knative/serving.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/knative/net-istio.sh"
fi

if [ "${ENVIRONMENT:?}" = 'dev' ]; then
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/pipelines.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/triggers.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/dashboard.sh"
fi

"${HELM:?}" upgrade --install --atomic "${APP:?}" "${BASE_DIR:?}"/charts/runhub-app \
  --namespace "${ENVIRONMENT:?}-${APP:?}" --create-namespace \
  --set "global.environment.${ENVIRONMENT:?}=true" \
  --values "${BASE_DIR:?}"/values.yaml
