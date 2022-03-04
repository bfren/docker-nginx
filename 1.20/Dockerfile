FROM bfren/alpine-s6:alpine3.15-4.1.0

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 80

ENV \
    # set to 0 to enable favicons - otherwise 204 (No Content) will always be returned
    NGINX_IGNORE_FAVICON=1 \
    # set to 1 to forward the access log to Docker stdout
    NGINX_FORWARD_ACCESS_LOG=0

COPY ./overlay /
COPY ./1.20/NGINX_BUILD /tmp/

RUN bf-install

VOLUME [ "/www" ]
