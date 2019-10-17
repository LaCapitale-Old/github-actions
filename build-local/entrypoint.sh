#!/bin/bash

set -e

: ${GCLOUD_REGISTRY:=docker.pkg.github.com}
: ${IMAGE:=$(echo $GITHUB_REPOSITORY | sed -e 's/[\/]/-/g' | awk '{print tolower($0)}')}
: ${GCP_PROJECT:=''}
: ${TAG:=$GITHUB_SHA}
: ${DEFAULT_BRANCH_TAG:=true}

docker build -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $GCLOUD_REGISTRY/$GCP_PROJECT/$IMAGE:$TAG
if [ "$DEFAULT_BRANCH_TAG" = "true" ]; then
  BRANCH=$(echo $GITHUB_REF | rev | cut -f 1 -d / | rev)
  if [ "$BRANCH" = "master" ]; then # TODO
    docker tag $IMAGE:$TAG $GCLOUD_REGISTRY/$IMAGE:$BRANCH
  fi
fi
