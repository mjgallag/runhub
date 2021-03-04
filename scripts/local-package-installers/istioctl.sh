#!/bin/sh
set -e

VERSION='1.8.2'
URL="https://github.com/istio/istio/releases/download/${VERSION:?}/istioctl-${VERSION:?}-osx.tar.gz"
SHA='83a8cc23629c0c918a1c704fe7097ede0af132e1f53c96fa875bd538cc9d36b2'
SHA_ALGORITHM=256

"${INSTALL_LOCAL_PACKAGE:?}" istioctl "${VERSION:?}" "${URL:?}" istioctl "${SHA:?}" "${SHA_ALGORITHM:?}"
