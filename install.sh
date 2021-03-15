#!/bin/sh
set -e

APP="${1:?}"
ENV="${2:?}"
PROVIDER="${3}"
SCRIPT_DIR="$(cd "$(dirname "${0:?}")" && pwd)"
SCRIPT_CONFIG_DIR="${SCRIPT_DIR:?}/.runhub"
SCRIPT_HOME_DIR="${SCRIPT_CONFIG_DIR:?}/home"
USER_HOME_DIR="${HOME:?}"
HOME="${SCRIPT_HOME_DIR:?}"
INSTALLERS_DIR="${SCRIPT_DIR:?}/shell-scripts/installers"

export SCRIPT_DIR
export SCRIPT_CONFIG_DIR
export INSTALLERS_DIR
export HOME

mkdir -p "${SCRIPT_HOME_DIR:?}"

if [ "${PROVIDER}" ]; then
  if [ "${PROVIDER:?}" = 'gcp' ]; then
    "${INSTALLERS_DIR:?}/infra/gcp.sh"
  fi
else
  export KUBECONFIG="${USER_HOME_DIR:?}/.kube/config"
fi

if [ "${ENV:?}" = 'dev' ] || [ "${ENV:?}" = 'prod' ]; then
  "${INSTALLERS_DIR:?}/k8s/istio.sh"
  "${INSTALLERS_DIR:?}/k8s/cert-manager.sh"
  "${INSTALLERS_DIR:?}/k8s/knative/serving.sh"
  "${INSTALLERS_DIR:?}/k8s/knative/net-istio.sh"
fi

if [ "${ENV:?}" = 'dev' ]; then
  "${INSTALLERS_DIR:?}/k8s/tekton/pipelines.sh"
  "${INSTALLERS_DIR:?}/k8s/tekton/triggers.sh"
  "${INSTALLERS_DIR:?}/k8s/tekton/dashboard.sh"
fi

"${INSTALLERS_DIR:?}/k8s/app.sh" "${APP:?}" "${ENV:?}"
