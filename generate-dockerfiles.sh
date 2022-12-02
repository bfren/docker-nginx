#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_REVISION="1.1.4"
echo "Base: ${BASE_REVISION}"

NGINX_VERSIONS="1.18 1.20 1.22 1.23"
for V in ${NGINX_VERSIONS} ; do

    echo "Nginx ${V}"

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_REVISION=${BASE_REVISION} \
        NGINX_MINOR=${V}
    )

    echo "${DOCKERFILE}" > ./${V}/Dockerfile

done

docker system prune -f
echo "Done."
