#!/bin/sh
set -e

BASE_DIR="$(cd "$(dirname "${0:?}")" && pwd)"
CONFIG_DIR="${BASE_DIR:?}/.runhub"
SCRIPT_HOME_DIR="${CONFIG_DIR:?}/home"
LOCAL_PACKAGES_DIR="${CONFIG_DIR:?}/packages"

export BASE_DIR
export USER_HOME_DIR="${HOME:?}"
export HOME="${SCRIPT_HOME_DIR:?}"
export KUBECONFIG="${USER_HOME_DIR:?}/.kube/config"
export LOCAL_PACKAGES_BIN_DIR="${LOCAL_PACKAGES_DIR:?}/bin"
export LOCAL_PACKAGES_TMP_DIR="${LOCAL_PACKAGES_DIR:?}/tmp"
export SCRIPTS_DIR="${BASE_DIR:?}/scripts"
export INSTALLERS_DIR="${SCRIPTS_DIR:?}/package-installers"
export LOCAL_PACKAGE_INSTALLERS_DIR="${INSTALLERS_DIR:?}/local"
export INSTALL_LOCAL_PACKAGE="${SCRIPTS_DIR:?}/install-local-package.sh"
export CLUSTER_PACKAGE_INSTALLERS_DIR="${INSTALLERS_DIR:?}/cluster"

mkdir -p "${SCRIPT_HOME_DIR:?}"
