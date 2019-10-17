#!/bin/bash

set -e

: ${GCLOUD_REGISTRY:=docker.pkg.github.com}
: ${IMAGE:='app'}
: ${TAG:=$GITHUB_SHA}
: ${DEFAULT_BRANCH_TAG:=true}
: ${REPO:=$(echo $GITHUB_REPOSITORY | awk '{print tolower($0)}')}

if [ -n "${GITHUB_ACCESS_TOKEN}" ]; then
  echo "Logging into docker.pkg.github.com with GITHUB_ACCESS_TOKEN..."
  docker login docker.pkg.github.com -u po.berube -p ${GITHUB_ACCESS_TOKEN}
else
  echo "GITHUB_ACCESS_TOKEN was empty, not performing auth" 1>&2
fi

docker push $GCLOUD_REGISTRY/$REPO/$IMAGE
