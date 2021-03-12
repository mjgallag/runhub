#!/bin/sh
set -e

VERSION='0.12.0'
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"

"${KUBECTL:?}" apply --filename \
  "https://storage.googleapis.com/tekton-releases/triggers/previous/v${VERSION:?}/release.yaml"

"${WAIT_FOR_DEPLOYMENTS:?}" tekton-pipelines
