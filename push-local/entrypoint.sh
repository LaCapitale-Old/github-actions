#!/bin/bash

set -e

: ${GCLOUD_REGISTRY:=docker.pkg.github.com}
: ${IMAGE:='app'}
: ${TAG:=$GITHUB_SHA}
: ${DEFAULT_BRANCH_TAG:=true}
: ${REPO:=$(echo $GITHUB_REPOSITORY | awk '{print tolower($0)}')}

if [ -n "${GITHUB_ACCESS_TOKEN}" && -n "${GITHUB_USERNAME}" ]; then
  echo "Logging into docker.pkg.github.com with GITHUB_ACCESS_TOKEN..."
  docker login docker.pkg.github.com -u ${GITHUB_USERNAME} -p ${GITHUB_ACCESS_TOKEN}
else
  echo "GITHUB_ACCESS_TOKEN or GITHUB_USERNAME was empty, not performing auth" 1>&2
  exit 1
fi

docker push $GCLOUD_REGISTRY/$REPO/$IMAGE:$TAG
docker push $GCLOUD_REGISTRY/$REPO/$IMAGE:latest
