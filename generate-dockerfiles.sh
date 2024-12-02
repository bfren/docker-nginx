#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_VERSION="5.4.17"
echo "Base: ${BASE_VERSION}"

ALPINE_EDITIONS="3.15 3.16 3.17 3.18 3.19 3.20"
for V in ${ALPINE_EDITIONS} ; do

    echo "Nginx for Alpine ${V}"
    NGINX_MINOR=`cat ./alpine${V}/overlay/tmp/NGINX_MINOR`

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_VERSION=${BASE_VERSION} \
        ALPINE_EDITION=${V}
    )

    echo "${DOCKERFILE}" > ./alpine${V}/Dockerfile

done

docker system prune -f
echo "Done."
