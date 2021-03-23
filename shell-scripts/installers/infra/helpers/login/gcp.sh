#!/bin/sh
set -e

"${BIN_DIR:?}/gcloud.sh" auth login --update-adc
