#!/bin/bash

set -e

: ${GCLOUD_REGISTRY:=gcr.io}
: ${IMAGE:=$(echo $GITHUB_REPOSITORY | sed -e 's/[\/]/-/g' | awk '{print tolower($0)}')}
: ${GCP_PROJECT:=''}
: ${TAG:=$GITHUB_SHA}
: ${DEFAULT_BRANCH_TAG:=true}

if [ -n "${GCLOUD_SERVICE_ACCOUNT_KEY}" ]; then
  echo "Logging into gcr.io with GCLOUD_SERVICE_ACCOUNT_KEY..."
  echo ${GCLOUD_SERVICE_ACCOUNT_KEY} | base64 --decode --ignore-garbage > /tmp/key.json
  gcloud auth activate-service-account --quiet --key-file /tmp/key.json
  gcloud auth configure-docker --quiet
else
  echo "GCLOUD_SERVICE_ACCOUNT_KEY was empty, not performing auth" 1>&2
fi

docker push $GCLOUD_REGISTRY/$GCP_PROJECT/$IMAGE
