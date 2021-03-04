#!/bin/sh
set -e

# shellcheck source=scripts/initialize.sh
. "$(dirname "${0:?}")/scripts/initialize.sh"

ENVIRONMENT="${1:?}"

"${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/istio.sh"
"${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/cert-manager.sh"
"${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/knative/serving.sh"
"${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/knative/net-istio.sh"

if [ "${ENVIRONMENT:?}" = 'dev' ]; then
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/pipelines.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/triggers.sh"
  "${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/tekton/dashboard.sh"
fi
