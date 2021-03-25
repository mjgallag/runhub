#!/bin/sh
set -e

printf '' > "${SCRIPT_DIR:?}/values-dev-infra.yaml"
printf '' > "${SCRIPT_DIR:?}/values-prod-infra.yaml"

for APP_ENV in 'dev' 'prod'; do
  for VALUES_ENV in 'dev' 'prod'; do
    HELM_VALUES_INFRA="${SCRIPT_CONFIG_DIR:?}/app/${APP:?}/${APP_ENV:?}/helm/values-${VALUES_ENV:?}-infra.yaml"

    if [ -f "${HELM_VALUES_INFRA:?}" ]; then
      cat "${HELM_VALUES_INFRA:?}" >> "${SCRIPT_DIR:?}/values-${VALUES_ENV:?}-infra.yaml"
    fi
  done
done
