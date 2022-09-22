FROM bfren/alpine-s6:alpine3.16-4.3.13

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-nginx"

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 80

ENV \
    # set to 0 to enable favicons - otherwise 204 (No Content) will always be returned
    NGINX_IGNORE_FAVICON=1 \
    # set to 1 to forward the access log to Docker stdout
    NGINX_FORWARD_ACCESS_LOG=0

COPY ./overlay /
COPY ./1.22/overlay /

RUN bf-install

VOLUME [ "/www" ]
