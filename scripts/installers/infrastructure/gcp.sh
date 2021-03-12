#!/bin/sh
set -e

GCLOUD="$("${BINARY_INSTALLERS_DIR:?}/gcloud.sh")"

if ! "${GCLOUD:?}" auth application-default print-access-token; then
  "${GCLOUD:?}" auth application-default login
fi
