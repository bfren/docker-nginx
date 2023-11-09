FROM bfren/alpine-s6:alpine3.17-5.0.0-dev

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-nginx"

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 80

COPY ./overlay /
COPY ./alpine3.17/overlay /

ENV \
    # set to 0 to enable favicons - otherwise 204 (No Content) will always be returned
    BF_NGINX_IGNORE_FAVICON=1 \
    # set to 1 to forward the access log to Docker stdout
    BF_NGINX_FORWARD_ACCESS_LOG=0 \
    # URI to load for healthcheck
    BF_NGINX_HEALTHCHECK_URI=http://localhost

RUN bf-install

VOLUME [ "/www" ]
