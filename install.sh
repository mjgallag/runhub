#!/bin/sh
set -e

# shellcheck source=scripts/initialize.sh
. "$(dirname "${0:?}")/scripts/initialize.sh"

"${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/cert-manager.sh"
"${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/istio.sh"
"${CLUSTER_PACKAGE_INSTALLERS_DIR:?}/knative-serving.sh"
