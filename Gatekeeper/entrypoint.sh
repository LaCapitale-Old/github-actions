#!/bin/bash

set -e


: ${CLIENT_VERSION:='1.0.1-alpha'}

: ${GCP_PROJECT_NAME:=''}
: ${SERVICE_TYPE:=''}
: ${REGISTRY_TYPE:=''}
: ${IMAGE_NAME:=''}
: ${CONFIG_URL:=''}
: ${RUN_DIR:=''}
: ${ARGS:=''}
: ${CLUSTER:='DEV'}
: ${GATEKEEPER_URL:='gatekeeper.infra1.lacapitale-gcp.com'}
: ${GATEKEEPER_HTTP_PORT:=''}
: ${GATEKEEPER_RPC_PORT:='50051'}
: ${GATEKEEPER_API_KEY:=''}

if [ -n "${GCP_PROJECT_NAME}" ]; then
  echo "downloading client..."
  curl https://storage.googleapis.com/github-action-artefacts/cloudInfra-golang-gatekeeper-client/${CLIENT_VERSION}/cloudInfra-golang-gatekeeper-client_${CLIENT_VERSION}_Linux_x86_64.tar.gz | tar xvz
  echo "starting client..."
 ./cloudInfra-golang-gatekeeper-client -serverURL=${GATEKEEPER_URL} -serverPort=${GATEKEEPER_HTTP_PORT} -grpcPort=${GATEKEEPER_RPC_PORT}
else
  echo "GCP_PROJECT_NAME was empty, we cannot call gatekeeper" 1>&2
fi
