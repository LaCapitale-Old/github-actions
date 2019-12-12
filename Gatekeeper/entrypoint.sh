#!/bin/bash

set -e


: ${CLIENT_VERSION:='1.0.0-alpha'}

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
  echo "downloading client..."
  curl https://storage.googleapis.com/github-action-artefacts/${CLIENT_VERSION}/cloudInfra-golang-gatekeeper-client_${CLIENT_VERSION}_Linux_x86_64.tar.gz | tar xvz
  echo "starting client..."
 ./cloudInfra-golang-gatekeeper-client -serverURL=${GATEKEEPER_URL}
else
  echo "GCP_PROJECT_NAME was empty, we cannot call gatekeeper" 1>&2
fi
