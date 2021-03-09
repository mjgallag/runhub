#!/bin/sh
set -ex

# shellcheck source=scripts/initialize.sh
. "$(dirname "${0:?}")/scripts/initialize.sh"

ENV="${1:?}"
APP="${2:?}"

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

"${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/app.sh" "${ENV:?}" "${APP:?}"

if [ "${ENV:?}" = 'prod' ]; then
  "${SCRIPTS_DIR:?}/generate-values-prod-k8s-creds.sh" "${APP:?}"
fi
