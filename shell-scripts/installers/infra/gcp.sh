#!/bin/sh
set -e

GCLOUD="$("${INSTALLERS_DIR:?}/bin/gcloud.sh")"

if ! "${GCLOUD:?}" auth application-default print-access-token; then
  "${GCLOUD:?}" auth application-default login
fi
