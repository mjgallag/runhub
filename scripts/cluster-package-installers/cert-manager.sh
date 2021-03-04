#!/bin/sh
set -e

VERSION='1.2.0'
KUBECTL="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/kubectl.sh")"
HELM="$("${LOCAL_PACKAGE_INSTALLERS_DIR:?}/helm.sh")"

"${KUBECTL:?}" apply --filename \
  "https://github.com/jetstack/cert-manager/releases/download/v${VERSION:?}/cert-manager.crds.yaml"
"${HELM:?}" repo add jetstack https://charts.jetstack.io
"${HELM:?}" repo update
"${HELM:?}" upgrade --install --atomic cert-manager jetstack/cert-manager --version "${VERSION:?}" \
  --namespace cert-manager --create-namespace \
  --set extraArgs='{--enable-certificate-owner-ref=true}'
