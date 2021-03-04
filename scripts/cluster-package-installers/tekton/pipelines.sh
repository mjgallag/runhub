#!/bin/sh
set -e

VERSION='0.21.0'
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"

"${KUBECTL:?}" apply --filename \
  "https://storage.googleapis.com/tekton-releases/pipeline/previous/v${VERSION:?}/release.yaml"
"${KUBECTL:?}" patch configmap/feature-flags \
  --namespace tekton-pipelines \
  --type merge \
  --patch '{"data":{"disable-affinity-assistant":"true"}}'
