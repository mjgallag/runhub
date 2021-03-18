#!/bin/sh
set -e

GSUTIL="$("${INSTALLERS_DIR:?}/bin/google-cloud-sdk.sh")/gsutil"

"${GSUTIL:?}" stat "gs://${ENV:?}-${APP:?}-terraform-state/default.tfstate"
