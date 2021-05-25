#!/bin/sh
set -e

VERSION='0.24.1'

curl -L \
  "https://storage.googleapis.com/tekton-releases/pipeline/previous/v${VERSION:?}/release.yaml" \
  | sed 's/disable-affinity-assistant: "false"/disable-affinity-assistant: "true"/' \
  | "${BIN_DIR:?}/kubectl.sh" apply --filename -
"${BIN_DIR:?}/kubectl.sh" patch configmap --namespace tekton-pipelines config-defaults \
  --type merge --patch '{"data":{"default-task-run-workspace-binding":"emptyDir: {}"}}'
"${INSTALLERS_DIR:?}/k8s/helpers/wait-for-deployments.sh" tekton-pipelines
