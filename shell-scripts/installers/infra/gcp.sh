#!/bin/sh
set -e

export BACKEND_TYPE='gcs'
GCLOUD="$("${INSTALLERS_DIR:?}/bin/google-cloud-sdk.sh")/gcloud"

if ! "${GCLOUD:?}" auth application-default print-access-token \
  --no-user-output-enabled --verbosity none; then
    "${GCLOUD:?}" auth login --update-adc
fi

"${INSTALLERS_DIR:?}/infra/helpers/terraform-apply.sh"
