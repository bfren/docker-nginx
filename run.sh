#!/bin/sh

IMAGE=`cat VERSION`
ALPINE=${1:-3.22}

docker buildx build \
    --load \
    --build-arg BF_IMAGE=nginx \
    --build-arg BF_VERSION=${IMAGE} \
    -f alpine${ALPINE}/Dockerfile \
    -t nginx-alpine${ALPINE}-dev \
    . \
    && \
    docker run -it -e BF_DEBUG=1 nginx-alpine${ALPINE}-dev sh
