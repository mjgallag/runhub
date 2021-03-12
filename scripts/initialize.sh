#!/bin/sh
set -e

BASE_DIR="$(cd "$(dirname "${0:?}")" && pwd)"
CONFIG_DIR="${BASE_DIR:?}/.runhub"
SCRIPT_HOME_DIR="${CONFIG_DIR:?}/home"
BINARIES_DIR="${CONFIG_DIR:?}/binaries"

export BASE_DIR
export USER_HOME_DIR="${HOME:?}"
export HOME="${SCRIPT_HOME_DIR:?}"
export BINARIES_BIN_DIR="${BINARIES_DIR:?}/bin"
export BINARIES_TMP_DIR="${BINARIES_DIR:?}/tmp"
export SCRIPTS_DIR="${BASE_DIR:?}/scripts"
export INSTALLERS_DIR="${SCRIPTS_DIR:?}/installers"
export BINARY_INSTALLERS_DIR="${INSTALLERS_DIR:?}/binary"
export INFRASTRUCTURE_INSTALLERS_DIR="${INSTALLERS_DIR:?}/infrastructure"
export KUBERNETES_INSTALLERS_DIR="${INSTALLERS_DIR:?}/kubernetes"
export INSTALL_BINARY="${SCRIPTS_DIR:?}/install-binary.sh"
export WAIT_FOR_DEPLOYMENTS="${SCRIPTS_DIR:?}/wait-for-deployments.sh"
export WRITE_PROD_K8S_CREDS="${SCRIPTS_DIR:?}/write-prod-k8s-creds.sh"

mkdir -p "${SCRIPT_HOME_DIR:?}"
