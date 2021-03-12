#!/bin/sh
set -e

VERSION='0.15.0'
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"

"${KUBECTL:?}" apply --filename \
  "https://github.com/tektoncd/dashboard/releases/download/v${VERSION:?}/tekton-dashboard-release.yaml"

"${SCRIPTS_DIR:?}/wait-for-deployments.sh" tekton-pipelines
