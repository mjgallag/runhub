#!/bin/sh
set -e

VERSION='0.14.0'
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"

"${KUBECTL:?}" apply --filename \
  "https://github.com/tektoncd/dashboard/releases/download/v${VERSION:?}/tekton-dashboard-release.yaml"