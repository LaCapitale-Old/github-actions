#!/bin/bash

set -e

: ${GCP_PROJECT_NAME:=''}
: ${SERVICE_TYPE:=''}
: ${REGISTRY_TYPE:=''}
: ${IMAGE_NAME:=''}
: ${CONFIG_URL:=''}
: ${RUN_DIR:=''}
: ${ARGS:=''}
: ${CLUSTER:=DEV}

if [ -n "${GCP_PROJECT_NAME}" ]; then
  echo "loading client v1.0.0-alpha"

else
  echo "GCP_PROJECT_NAME was empty, we cannot call gatekeeper" 1>&2
fi
