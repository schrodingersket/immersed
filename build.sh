#!/usr/bin/env bash
set -e

source ./env.sh

docker build \
       --build-arg IMMERSED_OCULUS_KEY=$IMMERSED_OCULUS_KEY \
       --build-arg IMMERSED_USERNAME=$IMMERSED_USERNAME \
       --build-arg IMMERSED_VERSION=$IMMERSED_VERSION \
       -t schrodingersket/immersed:$IMMERSED_VERSION .
