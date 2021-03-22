#!/bin/sh
set -e

NAME="${1:?}"
VERSION="${2:?}"
URL="${3:?}"
ARCHIVE_BIN_PATH="${4:?}"
SHA="${5:?}"
SHA_ALGORITHM="${6:?}"
INSTALL_DIR="${SCRIPT_CONFIG_DIR:?}/bin/${NAME:?}/${VERSION:?}"
INSTALL_PATH="${INSTALL_DIR:?}/${ARCHIVE_BIN_PATH:?}"
TMP_DIR="${SCRIPT_CONFIG_DIR:?}/bin/tmp/install"
ARCHIVE_PATH="${TMP_DIR:?}/archive"

if [ ! -f "${INSTALL_PATH:?}" ]; then
  mkdir -p "${INSTALL_DIR:?}" "${TMP_DIR:?}"
  curl -L "${URL:?}" -o "${ARCHIVE_PATH:?}"
  echo "${SHA:?}  ${ARCHIVE_PATH:?}" | shasum -csa "${SHA_ALGORITHM:?}"
  tar -xf "${ARCHIVE_PATH:?}" -C "${INSTALL_DIR:?}"
fi

echo "${INSTALL_PATH:?}"
