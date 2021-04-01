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
export BACKEND_TYPE='gcs'
export LOGIN_ERROR='Error: storage.NewClient() failed: dialing: google: could not find default credentials. See https://developers.google.com/accounts/docs/application-default-credentials for more information.'
export BACKEND_ERROR="Error: Failed to get existing workspaces: querying Cloud Storage failed: storage: bucket doesn't exist"

"${INSTALLERS_DIR:?}/infra/helpers/terraform-apply.sh"
"${BIN_DIR:?}/kubectl.sh" patch StorageClass standard --type merge \
  --patch '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
"${BIN_DIR:?}/kubectl.sh" patch StorageClass standard-rwo --type merge \
  --patch '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
