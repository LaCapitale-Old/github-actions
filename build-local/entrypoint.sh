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

docker pull $GCLOUD_REGISTRY/$REPO/$IMAGE:latest
docker build -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $GCLOUD_REGISTRY/$REPO/$IMAGE:$TAG
if [ "$DEFAULT_BRANCH_TAG" = "true" ]; then
  BRANCH=$(echo $GITHUB_REF | rev | cut -f 1 -d / | rev)
  if [ "$BRANCH" = "master" ]; then # TODO
    docker tag $IMAGE:$TAG $GCLOUD_REGISTRY/$REPO/$IMAGE:$BRANCH
  fi
fi
