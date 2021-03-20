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
export CLOUDSDK_CONTAINER_USE_APPLICATION_DEFAULT_CREDENTIALS='True'
GCLOUD="$("${INSTALLERS_DIR:?}/bin/gcloud.sh")"
TERRAFORM="${INSTALLERS_DIR:?}/bin/terraform.sh"

if ! "${GCLOUD:?}" auth application-default print-access-token \
  --no-user-output-enabled --verbosity none; then
    "${GCLOUD:?}" auth application-default login --disable-quota-project --verbosity error
fi

"${INSTALLERS_DIR:?}/infra/helpers/terraform-apply.sh"

REGION="$("${TERRAFORM:?}" -chdir="${APP_ENV_TERRAFORM_DIR:?}" output -raw region)"
"${GCLOUD:?}" container clusters get-credentials \
  "${ENV:?}-${APP:?}" --project "${ENV:?}-${APP:?}" --region "${REGION:?}"
