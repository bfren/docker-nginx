#!/bin/sh

IMAGE=`cat VERSION`
ALPINE=${1:-3.17}

docker buildx build \
    --build-arg BF_IMAGE=nginx \
    --build-arg BF_VERSION=${IMAGE} \
    -f alpine${ALPINE}/Dockerfile \
    -t nginx-alpine${ALPINE}-dev \
    . \
    && \
    docker run -it nginx-alpine${ALPINE}-dev sh
