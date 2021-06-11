FROM bcgdesign/alpine-s6:alpine3.13-2.1.3

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx" \
    org.label-schema.version="Alpine 3.13" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

# fix for creating S6-compatible Nginx logs
RUN s6-rmrf /etc/s6/services/s6-fdholderd/down

EXPOSE 80

ENV \
    # set to 0 to enable favicons - otherwise 204 (No Content) will always be returned
    NGINX_IGNORE_FAVICON=1

COPY ./overlay /
COPY ./alpine3.13/NGINX_BUILD /tmp/VERSION

RUN bf-install

VOLUME [ "/www" ]
