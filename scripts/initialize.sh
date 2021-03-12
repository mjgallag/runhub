#!/bin/sh
set -e

BASE_DIR="$(cd "$(dirname "${0:?}")" && pwd)"
CONFIG_DIR="${BASE_DIR:?}/.runhub"
SCRIPT_HOME_DIR="${CONFIG_DIR:?}/home"
BINARY_PACKAGES_DIR="${CONFIG_DIR:?}/packages"

export BASE_DIR
export USER_HOME_DIR="${HOME:?}"
export HOME="${SCRIPT_HOME_DIR:?}"
export KUBECONFIG="${USER_HOME_DIR:?}/.kube/config"
export BINARY_PACKAGES_BIN_DIR="${BINARY_PACKAGES_DIR:?}/bin"
export BINARY_PACKAGES_TMP_DIR="${BINARY_PACKAGES_DIR:?}/tmp"
export SCRIPTS_DIR="${BASE_DIR:?}/scripts"
export INSTALLERS_DIR="${SCRIPTS_DIR:?}/package-installers"
export BINARY_PACKAGE_INSTALLERS_DIR="${INSTALLERS_DIR:?}/binary"
export CLUSTER_PACKAGE_INSTALLERS_DIR="${INSTALLERS_DIR:?}/cluster"
export INSTALL_BINARY_PACKAGE="${SCRIPTS_DIR:?}/install-binary-package.sh"
export WAIT_FOR_DEPLOYMENTS="${SCRIPTS_DIR:?}/wait-for-deployments.sh"
export WRITE_PROD_K8S_CREDS="${SCRIPTS_DIR:?}/write-prod-k8s-creds.sh"

mkdir -p "${SCRIPT_HOME_DIR:?}"
