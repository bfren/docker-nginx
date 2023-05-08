#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_REVISION="4.4.17"
echo "Base: ${BASE_REVISION}"

ALPINE_VERSIONS="3.13 3.14 3.15 3.16 3.17 edge"
for V in ${ALPINE_VERSIONS} ; do

    echo "Nginx ${V}"
    NGINX_MINOR=`cat ./alpine${V}/overlay/tmp/NGINX_MINOR`

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_REVISION=${BASE_REVISION} \
        ALPINE_MINOR=${V} \
        NGINX_MINOR=${NGINX_MINOR}
    )

    echo "${DOCKERFILE}" > ./alpine${V}/Dockerfile

done

docker system prune -f
echo "Done."
