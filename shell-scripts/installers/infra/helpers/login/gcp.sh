#!/bin/sh
set -e

"${BIN_DIR:?}/gcloud.sh" auth application-default login --disable-quota-project --verbosity error
