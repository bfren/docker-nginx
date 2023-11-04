#!/bin/sh

IMAGE=`cat VERSION`
ALPINE=${1:-3.18}

docker buildx build \
    --load \
    --progress plain \
    --build-arg BF_IMAGE=nginx \
    --build-arg BF_VERSION=${IMAGE} \
    -f alpine${ALPINE}/Dockerfile \
    -t nginx-alpine${ALPINE}-dev \
    . \
    && \
    docker run -it -e BF_DEBUG=1 nginx-alpine${ALPINE}-dev sh
