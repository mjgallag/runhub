#!/bin/sh
set -e

VERSION='0.15.0'
KUBECTL="$("${BINARY_INSTALLERS_DIR:?}/kubectl.sh")"

"${KUBECTL:?}" apply --filename \
  "https://github.com/tektoncd/dashboard/releases/download/v${VERSION:?}/tekton-dashboard-release.yaml"

"${KUBERNETES_INSTALLER_HELPERS_DIR:?}/wait-for-deployments.sh" tekton-pipelines
