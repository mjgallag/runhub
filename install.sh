#!/bin/sh
set -e

# shellcheck source=scripts/initialize.sh
. "$(dirname "${0:?}")/scripts/initialize.sh"

APP="${1:?}"
ENV="${2:?}"

if [ "${ENV:?}" = 'dev' ] || [ "${ENV:?}" = 'prod' ]; then
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/istio.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/cert-manager.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/knative/serving.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/knative/net-istio.sh"
fi

if [ "${ENV:?}" = 'dev' ]; then
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/pipelines.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/triggers.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/dashboard.sh"
fi

"${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/app.sh" "${APP:?}" "${ENV:?}"

if [ "${ENV:?}" = 'prod' ]; then
  "${WRITE_PROD_K8S_CREDS:?}" "${APP:?}"
fi
