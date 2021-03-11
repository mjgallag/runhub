#!/bin/sh
set -e

# shellcheck source=scripts/initialize.sh
. "$(dirname "${0:?}")/scripts/initialize.sh"

APP="${1:?}"
ENV="${2:?}"

if [ "${ENV:?}" = "${ENV_DEV:?}" ] || [ "${ENV:?}" = "${ENV_PROD:?}" ]; then
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/istio.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/cert-manager.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/knative/serving.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/knative/net-istio.sh"
fi

if [ "${ENV:?}" = "${ENV_DEV:?}" ]; then
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/pipelines.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/triggers.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/dashboard.sh"
fi

"${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/app.sh" "${APP:?}" "${ENV:?}"

if [ "${ENV:?}" = "${ENV_PROD:?}" ]; then
  "${SCRIPTS_DIR:?}/write-prod-k8s-creds.sh" "${APP:?}"
fi
