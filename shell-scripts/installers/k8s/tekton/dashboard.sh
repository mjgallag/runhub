#!/bin/sh
set -e

VERSION='0.16.0'

"${BIN_DIR:?}/kubectl.sh" apply --filename \
  "https://github.com/tektoncd/dashboard/releases/download/v${VERSION:?}/tekton-dashboard-release.yaml"
"${INSTALLERS_DIR:?}/k8s/helpers/wait-for-deployments.sh" tekton-pipelines
