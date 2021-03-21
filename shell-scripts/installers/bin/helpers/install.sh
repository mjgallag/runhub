#!/bin/sh
set -e

NAME="${1:?}"
VERSION="${2:?}"
URL="${3:?}"
ARCHIVE_BIN_PATH="${4:?}"
SHA="${5:?}"
SHA_ALGORITHM="${6:?}"
BIN_DIR="${SCRIPT_CONFIG_DIR:?}/bin/${NAME:?}/${VERSION:?}"
BIN_PATH="${BIN_DIR:?}/${ARCHIVE_BIN_PATH:?}"
TMP_DIR="${SCRIPT_CONFIG_DIR:?}/tmp-bin-${NAME:?}-${VERSION:?}"
ARCHIVE_PATH="${TMP_DIR:?}/archive"

if [ ! -f "${BIN_PATH:?}" ]; then
  mkdir -p "${BIN_DIR:?}" "${TMP_DIR:?}"
  curl -L "${URL:?}" -o "${ARCHIVE_PATH:?}"
  echo "${SHA:?}  ${ARCHIVE_PATH:?}" | shasum -csa "${SHA_ALGORITHM:?}"
  tar -xf "${ARCHIVE_PATH:?}" -C "${BIN_DIR:?}"
  rm -r "${TMP_DIR:?}"
fi

echo "${BIN_PATH:?}"
