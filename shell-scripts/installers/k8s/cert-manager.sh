#!/bin/sh
set -e

VERSION='1.3.1'

"${BIN_DIR:?}/kubectl.sh" apply --filename \
  "https://github.com/jetstack/cert-manager/releases/download/v${VERSION:?}/cert-manager.crds.yaml"
"${BIN_DIR:?}/helm.sh" repo add jetstack https://charts.jetstack.io
"${BIN_DIR:?}/helm.sh" repo update
"${BIN_DIR:?}/helm.sh" upgrade --install --atomic --namespace cert-manager --create-namespace \
  cert-manager jetstack/cert-manager --version "${VERSION:?}" \
  --set extraArgs='{--enable-certificate-owner-ref=true}'
