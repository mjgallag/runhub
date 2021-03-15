#!/bin/sh
set -e

BASE_DIR="$(cd "$(dirname "${0:?}")" && pwd)"
export CONFIG_DIR="${BASE_DIR:?}/.runhub"
SCRIPT_HOME_DIR="${CONFIG_DIR:?}/home"

export BASE_DIR
export USER_HOME_DIR="${HOME:?}"
export HOME="${SCRIPT_HOME_DIR:?}"
export SCRIPTS_DIR="${BASE_DIR:?}/shell-scripts"
export INSTALLERS_DIR="${SCRIPTS_DIR:?}/installers"
export BINARY_INSTALLERS_DIR="${INSTALLERS_DIR:?}/bin"
export INFRASTRUCTURE_INSTALLERS_DIR="${INSTALLERS_DIR:?}/infra"
export KUBERNETES_INSTALLERS_DIR="${INSTALLERS_DIR:?}/k8s"
export BINARY_INSTALLER_HELPERS_DIR="${BINARY_INSTALLERS_DIR:?}/helpers"
export KUBERNETES_INSTALLER_HELPERS_DIR="${KUBERNETES_INSTALLERS_DIR:?}/helpers"

mkdir -p "${SCRIPT_HOME_DIR:?}"
