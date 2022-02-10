FROM bfren/alpine-s6:alpine3.15-4.0.0

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 80

ENV \
    # set to 0 to enable favicons - otherwise 204 (No Content) will always be returned
    NGINX_IGNORE_FAVICON=1

COPY ./overlay /
COPY ./1.20/NGINX_BUILD /tmp/VERSION

RUN bf-install

VOLUME [ "/www" ]
