#!/bin/sh
set -e

VERSION='0.12.1'

"${BIN_DIR:?}/kubectl.sh" apply --filename \
  "https://storage.googleapis.com/tekton-releases/triggers/previous/v${VERSION:?}/release.yaml"

"${INSTALLERS_DIR:?}/k8s/helpers/wait-for-deployments.sh" tekton-pipelines
