#!/bin/sh

IMAGE=`cat VERSION`
ALPINE=${1:-3.19}

docker buildx build \
    --load \
    --build-arg BF_IMAGE=nginx \
    --build-arg BF_VERSION=${IMAGE} \
    -f alpine${ALPINE}/Dockerfile \
    -t nginx-alpine${ALPINE}-test \
    . \
    && \
    docker run --rm nginx-alpine${ALPINE}-test env -i nu -c "use bf test ; test"
