#!/bin/sh
set -e

VERSION='0.21.0'
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"


curl -L \
  "https://storage.googleapis.com/tekton-releases/pipeline/previous/v${VERSION:?}/release.yaml" \
  | sed 's/disable-affinity-assistant: "false"/disable-affinity-assistant: "true"/' \
  | kubectl apply --filename -
