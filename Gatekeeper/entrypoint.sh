#!/bin/bash

set -e

: ${GCP_PROJECT_NAME:=''}
: ${SERVICE_TYPE:=''}
: ${REGISTRY_TYPE:=''}
: ${IMAGE_NAME:=''}
: ${CONFIG_URL:=''}
: ${RUN_DIR:=''}
: ${ARGS:=''}
: ${CLUSTER:='DEV'}
: ${GATEKEEPER_URL:='http://127.0.0.1:8080'}

if [ -n "${GCP_PROJECT_NAME}" ]; then
  echo "unzipping client v1.0.0-alpha..."
  ./cloudInfra-golang-gatekeeper-client -serverURL=${GATEKEEPER_URL}
else
  echo "GCP_PROJECT_NAME was empty, we cannot call gatekeeper" 1>&2
fi
