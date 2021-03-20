#!/bin/sh
set -e

NAME="${1:?}"
VERSION="${2:?}"
URL="${3:?}"
ARCHIVE_BIN_PATH="${4:?}"
SHA="${5:?}"
SHA_ALGORITHM="${6:?}"
BIN_DIR="${SCRIPT_CONFIG_DIR:?}/bin"
NAME_DIR="${BIN_DIR:?}/${NAME:?}"
VERSION_DIR="${NAME_DIR:?}/${VERSION:?}"
BIN_PATH="${VERSION_DIR:?}/${ARCHIVE_BIN_PATH:?}"
TMP_DIR="${SCRIPT_CONFIG_DIR:?}/bin-tmp-${NAME:?}-${VERSION:?}"
ARCHIVE_PATH="${TMP_DIR:?}/${NAME:?}-${VERSION:?}"

if [ ! -f "${BIN_PATH:?}" ]; then
  mkdir -p "${BIN_DIR:?}" "${TMP_DIR:?}"
  rm -rf "${NAME_DIR:?}"
  mkdir -p "${VERSION_DIR:?}"
  curl -L "${URL:?}" -o "${ARCHIVE_PATH:?}"
  echo "${SHA:?}  ${ARCHIVE_PATH:?}" | shasum -csa "${SHA_ALGORITHM:?}"
  tar -xf "${ARCHIVE_PATH:?}" -C "${VERSION_DIR:?}"
  rm -r "${TMP_DIR:?}"
fi

echo "${BIN_PATH:?}"
