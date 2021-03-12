#!/bin/sh
set -e

ISTIOCTL="$("${BINARY_PACKAGE_INSTALLERS_DIR:?}/istioctl.sh")"

"${ISTIOCTL:?}" install --skip-confirmation --filename - <<EOF
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
spec:
  values:
    global:
      proxy:
        autoInject: disabled
      useMCP: false
      # The third-party-jwt is not enabled on all k8s.
      # See: https://istio.io/docs/ops/best-practices/security/#configure-third-party-service-account-tokens
      jwtPolicy: first-party-jwt

  addonComponents:
    pilot:
      enabled: true

  components:
    ingressGateways:
      - name: istio-ingressgateway
        enabled: true
EOF
