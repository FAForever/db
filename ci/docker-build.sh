#!/bin/bash
set -e

echo -e 'travis_fold:start:docker_build'
export REPO=faforever/faf-db-migrations

if [ -n "${TRAVIS_TAG}" ]; then
      docker login -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}";
      docker tag faf-db-migrations ${REPO}:${TRAVIS_TAG};
      docker push ${REPO};
else
    echo "No tag detected, skipping docker build"
fi

echo -e 'travis_fold:end:docker_build'
