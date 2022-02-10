FROM bfren/alpine-s6:alpine3.12-4.0.0

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 80

ENV \
    # set to 0 to enable favicons - otherwise 204 (No Content) will always be returned
    NGINX_IGNORE_FAVICON=1

COPY ./overlay /
COPY ./1.18/NGINX_BUILD /tmp/

RUN bf-install

VOLUME [ "/www" ]
