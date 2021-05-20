#!/bin/sh
set -e

"${BIN_DIR:?}/istioctl.sh" install --skip-confirmation
