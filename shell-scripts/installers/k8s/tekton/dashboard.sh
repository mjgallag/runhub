#!/bin/sh
set -e

VERSION='0.15.0'
KUBECTL="${INSTALLERS_DIR:?}/bin/kubectl.sh"

"${KUBECTL:?}" apply --filename \
  "https://github.com/tektoncd/dashboard/releases/download/v${VERSION:?}/tekton-dashboard-release.yaml"

"${INSTALLERS_DIR:?}/k8s/helpers/wait-for-deployments.sh" tekton-pipelines
