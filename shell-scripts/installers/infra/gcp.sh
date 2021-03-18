#!/bin/sh
set -e

GCLOUD="$("${INSTALLERS_DIR:?}/bin/google-cloud-sdk.sh")/gcloud"

if ! "${GCLOUD:?}" auth application-default print-access-token \
  --no-user-output-enabled --verbosity none; then
    "${GCLOUD:?}" auth application-default login --disable-quota-project --verbosity error
fi
