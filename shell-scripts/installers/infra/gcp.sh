#!/bin/sh
set -e

VARIABLE_DEFINITIONS="$(cat <<EOF
variable "region" {
  type    = string
  default = "us-central1"
}

variable "billing_account" {
  type    = string
  default = "My Billing Account"
}
EOF
)"
export VARIABLE_DEFINITIONS
VARIABLE_ASSIGNMENTS="$(cat <<EOF
  region          = var.region
  billing_account = var.billing_account
EOF
)"
export VARIABLE_ASSIGNMENTS
OUTPUT_DEFINITIONS="$(cat <<EOF
output "region" {
  value = var.region
}
EOF
)"
export OUTPUT_DEFINITIONS
export BACKEND_TYPE='gcs'

if ! "${BIN_DIR:?}/gcloud.sh" auth application-default print-access-token \
  --no-user-output-enabled --verbosity none; then
    "${BIN_DIR:?}/gcloud.sh" auth login --update-adc
fi

"${INSTALLERS_DIR:?}/infra/helpers/terraform-apply.sh"

REGION="$("${BIN_DIR:?}/terraform.sh" output -raw region)"
"${BIN_DIR:?}/gcloud.sh" container clusters get-credentials \
  "${ENV:?}-${APP:?}" --project "${ENV:?}-${APP:?}" --region "${REGION:?}"
