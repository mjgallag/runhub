#!/bin/sh
set -e

BASE_DIR="$(cd "$(dirname "${0:?}")" && pwd)"
CONFIG_DIR="${BASE_DIR:?}/.runhub"
LOCAL_PACKAGES_DIR="${CONFIG_DIR:?}/packages"

export BASE_DIR
export LOCAL_PACKAGES_BIN_DIR="${LOCAL_PACKAGES_DIR:?}/bin"
export LOCAL_PACKAGES_TMP_DIR="${LOCAL_PACKAGES_DIR:?}/tmp"
export SCRIPTS_DIR="${BASE_DIR:?}/scripts"
export LOCAL_PACKAGE_INSTALLERS_DIR="${SCRIPTS_DIR:?}/local-package-installers"
export INSTALL_LOCAL_PACKAGE="${SCRIPTS_DIR:?}/install-local-package.sh"
export CLUSTER_PACKAGE_INSTALLERS_DIR="${SCRIPTS_DIR:?}/cluster-package-installers"
