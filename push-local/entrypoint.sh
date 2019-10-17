#!/bin/bash

set -e

: ${GCLOUD_REGISTRY:=docker.pkg.github.com}
: ${IMAGE:=$(echo $GITHUB_REPOSITORY | sed -e 's/[\/]/-/g' | awk '{print tolower($0)}')}
: ${GCP_PROJECT:=''}
: ${TAG:=$GITHUB_SHA}
: ${DEFAULT_BRANCH_TAG:=true}

if [ -n "${GITHUB_ACCESS_TOKEN}" ]; then
  echo "Logging into docker.pkg.github.com with GITHUB_ACCESS_TOKEN..."
  docker login docker.pkg.github.com -u po.berube -p ${GITHUB_ACCESS_TOKEN}
else
  echo "GITHUB_ACCESS_TOKEN was empty, not performing auth" 1>&2
fi

docker push $GCLOUD_REGISTRY/$GCP_PROJECT/$IMAGE
