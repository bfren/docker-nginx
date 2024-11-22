#!/bin/sh

IMAGE=nginx
VERSION=`cat VERSION`
ALPINE=${1:-3.20}
TAG=${IMAGE}-test

docker buildx build \
    --load \
    --build-arg BF_IMAGE=${IMAGE} \
    --build-arg BF_VERSION=${VERSION} \
    -f alpine${ALPINE}/Dockerfile \
    -t ${TAG} \
    . \
    && \
    docker run --entrypoint /test ${TAG}
