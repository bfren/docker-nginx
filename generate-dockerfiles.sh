#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_REVISION="3.2.3"
echo "Base: ${BASE_REVISION}"

NGINX_VERSIONS="1.18 1.20 edge"
for V in ${NGINX_VERSIONS} ; do

    echo "Nginx ${V}"
    ALPINE_MINOR=`cat ./${V}/ALPINE_MINOR`

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_REVISION=${BASE_REVISION} \
        ALPINE_MINOR=${ALPINE_MINOR} \
        NGINX_MINOR=${V}
    )

    echo "${DOCKERFILE}" > ./${V}/Dockerfile

done

docker system prune -f
echo "Done."
