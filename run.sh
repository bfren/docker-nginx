#!/bin/sh

IMAGE=`cat VERSION`
NGINX=${1:-1.20}

docker buildx build \
    --build-arg BF_IMAGE=nginx \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${NGINX}/Dockerfile \
    -t nginx${NGINX}-dev \
    . \
    && \
    docker run -it nginx${NGINX}-dev sh
