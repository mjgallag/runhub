#!/bin/sh
set -e

mkdir -p "$(dirname "${BIN_STDERR:?}")"
printf '' > "${BIN_STDERR:?}"
"$@" 2> "${BIN_STDERR:?}"
