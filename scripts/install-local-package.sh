#!/bin/sh
set -e

NAME="${1:?}"
VERSION="${2:?}"
URL="${3:?}"
ARCHIVE_BIN_PATH="${4:?}"
SHA="${5:?}"
DIR="${LOCAL_PACKAGES_BIN_DIR:?}/${NAME:?}"
VERSION_DIR="${DIR:?}/${VERSION:?}"
BIN_PATH="${VERSION_DIR:?}/${ARCHIVE_BIN_PATH:?}"
ARCHIVE_PATH="${LOCAL_PACKAGES_TMP_DIR:?}/${NAME:?}-${VERSION:?}"

if [ ! -f "${BIN_PATH:?}" ]; then
  mkdir -p "${LOCAL_PACKAGES_BIN_DIR:?}" "${LOCAL_PACKAGES_TMP_DIR:?}"
  rm -rf "${DIR:?}"
  mkdir -p "${VERSION_DIR:?}"
  curl -L "${URL:?}" -o "${ARCHIVE_PATH:?}"
  echo "${SHA:?}  ${ARCHIVE_PATH:?}" | shasum -csa 256
  tar -xf "${ARCHIVE_PATH:?}" -C "${VERSION_DIR:?}"
  rm -r "${LOCAL_PACKAGES_TMP_DIR:?}"
fi

echo "${BIN_PATH:?}"
