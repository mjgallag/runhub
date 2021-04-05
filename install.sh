#!/bin/sh
set -e

export APP="${1:?}"
export ENV="${2:?}"
export INFRA="${3}"
SCRIPT_DIR="$(cd "$(dirname "${0:?}")" && pwd)"
export SCRIPT_DIR
export SCRIPT_CONFIG_DIR="${SCRIPT_DIR:?}/.runhub"
SCRIPT_HOME_DIR="${SCRIPT_CONFIG_DIR:?}/home"
USER_HOME_DIR="${HOME:?}"
export HOME="${SCRIPT_HOME_DIR:?}"
export INSTALLERS_DIR="${SCRIPT_DIR:?}/shell-scripts/installers"
export BIN_DIR="${INSTALLERS_DIR:?}/bin"
export BIN_STDERR="${SCRIPT_CONFIG_DIR:?}/bin/tmp/stderr"
APP_ENV_DIR="${SCRIPT_CONFIG_DIR:?}/app/${APP:?}/${ENV:?}"
export CONFIG_DIR="${SCRIPT_DIR:?}/config"
export GENERATED_CONFIG_DIR="${CONFIG_DIR:?}/generated"

mkdir -p "${SCRIPT_HOME_DIR:?}" "${GENERATED_CONFIG_DIR:?}"

for VALUES_ENV in 'dev' 'prod'; do
  printf '' > "${GENERATED_CONFIG_DIR:?}/values-${VALUES_ENV:?}-from-${ENV:?}.yaml"
done

if [ "${INFRA}" ]; then
  export APP_ENV_TERRAFORM_DIR="${APP_ENV_DIR:?}/terraform"

  mkdir -p "${APP_ENV_TERRAFORM_DIR:?}"
  "${INSTALLERS_DIR:?}/infra/${INFRA:?}.sh"
else
  export KUBECONFIG="${USER_HOME_DIR:?}/.kube/config"
fi

"${INSTALLERS_DIR:?}/k8s/istio.sh"
"${INSTALLERS_DIR:?}/k8s/cert-manager.sh"
"${INSTALLERS_DIR:?}/k8s/knative/serving.sh"
"${INSTALLERS_DIR:?}/k8s/knative/net-istio.sh"

if [ "${ENV:?}" = 'dev' ]; then
  "${INSTALLERS_DIR:?}/k8s/tekton/pipelines.sh"
  "${INSTALLERS_DIR:?}/k8s/tekton/triggers.sh"
  "${INSTALLERS_DIR:?}/k8s/tekton/dashboard.sh"
fi

"${INSTALLERS_DIR:?}/k8s/app.sh"
