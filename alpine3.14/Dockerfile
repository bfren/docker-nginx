FROM bfren/alpine-s6:alpine3.14-2.2.12

# fix for creating S6-compatible Nginx logs
RUN s6-rmrf /etc/s6/services/s6-fdholderd/down

EXPOSE 80

ENV \
    # set to 0 to enable favicons - otherwise 204 (No Content) will always be returned
    NGINX_IGNORE_FAVICON=1

COPY ./overlay /
COPY ./alpine3.14/NGINX_BUILD /tmp/VERSION

RUN bf-install

VOLUME [ "/www" ]
