#!/bin/sh
set -e

VERSION='0.22.0'

curl -L \
  "https://storage.googleapis.com/tekton-releases/pipeline/previous/v${VERSION:?}/release.yaml" \
  | sed 's/disable-affinity-assistant: "false"/disable-affinity-assistant: "true"/' \
  | "${BIN_DIR:?}/kubectl.sh" apply --selector knative.dev/crd-install!=true --filename -
"${INSTALLERS_DIR:?}/k8s/helpers/wait-for-deployments.sh" tekton-pipelines
